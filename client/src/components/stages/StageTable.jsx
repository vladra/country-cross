import React, { Component } from 'react';
import PropTypes from 'prop-types';
import { graphql } from 'react-apollo';
import { Link, withRouter } from 'react-router-dom';
import { groupBy, max, sumBy, times } from 'lodash';

import { GetStage } from 'gql/queries';
import { Table } from 'components/Table';

// Helpers
const findAllLapsByRacer = ({ laps, racerId }) =>
  laps.filter(l => l.racer_id === parseInt(racerId));

const prepareRacers = ({ racers, laps }) =>
  racers.map((r) => {
    const racerLaps = findAllLapsByRacer({ laps, racerId: r.id });

    return {
      ...r,
      laps: racerLaps,
      totalLaps: racerLaps.count,
      totalTime: sumBy(racerLaps, 'time'),
    };
  });

const findRacer = ({ racers, racerId }) =>
  racers.find(r => r.id === racerId);

const timeToHuman = (time) => {
  const ms = time % 1000;
  const sec = Math.round((time / 1000) % 60);
  const min = Math.round((time / 1000 / 60) % 60);

  return `${min}:${sec}.${ms}`;
};

// Generate Columns
const generateLapsColumns = (racers) => {
  const total = max(racers.map(r => (r.laps || []).length));

  return times(total, (i) => {
    const lapNumber = i + 1;

    return {
      id: `lap-${i + 1}`,
      Header: `${i + 1} круг`,
      accessor: ({ id: racerId }) => {
        const lap = findRacer({ racers, racerId }).laps.find(l => l.number === lapNumber);
        return lap ? lap.h_time : '';
      },
    };
  });
};

const generateColumns = racers => [{
  Header: 'Имя',
  accessor: 'name',
}, ...generateLapsColumns(racers), {
  id: 'totalTime',
  Header: 'Общее время',
  accessor: ({ id: racerId }) => sumBy(findRacer({ racers, racerId }), 'time'),
  Cell: ({ original: { id: racerId } }) => timeToHuman(findRacer({ racers, racerId }).totalTime),
  sortMethod: (a, b) => {
    console.log(a, b)
    return 0
  },
}];


const mapResultToProps = ({ data }) => {
  const { loading } = data;
  if (!data.stage) return { loading };

  const { stage } = data;

  return { stage, loading };
};

const mapPropsToOptions = ({ match }) => ({
  variables: { id: match.params.id },
});


const StagesIndexTable = ({ stage, loading }) => {
  if (loading) return null;

  const racers = prepareRacers(stage);

  return (
    <Table
      columns={generateColumns(racers)}
      data={racers}
    />
  );
};

export default graphql(GetStage, {
  props: mapResultToProps,
  options: mapPropsToOptions,
})(withRouter(StagesIndexTable));
