import React, { Component } from 'react';
import PropTypes from 'prop-types';
import { graphql } from 'react-apollo';
import { Link, withRouter } from 'react-router-dom';
import { groupBy, max, minBy, sumBy, times } from 'lodash';

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
      showOnGraph: true,
      laps: racerLaps,
      totalLaps: racerLaps.count,
      totalTime: sumBy(racerLaps, 'time'),
      fastestLap: minBy(racerLaps, 'time'),
    };
  });

const prepareStage = ({ stage, laps }) => {
  const fastestLap = minBy(laps, 'time');

  return { ...stage, fastestLap };
};

const findRacer = ({ racers, racerId }) =>
  racers.find(r => r.id === racerId);

const timeToHuman = (time) => {
  const ms = time % 1000;
  const sec = Math.round((time / 1000) % 60);
  const min = Math.round((time / 1000 / 60) % 60);

  return `${min}:${sec}.${ms}`;
};

// Generate Columns
const generateLapsColumns = ({ stage, racers }) => {
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
      Cell: ({ original: { id: racerId, fastestLap }, row }) => { // eslint-disable-line
        let style = {};
        const lapTime = row[`lap-${lapNumber}`];
        console.log(stage.fastestLap.number, lapNumber, racerId, stage.fastestLap.racer_id)
        if (stage.fastestLap.number === lapNumber && racerId === stage.fastestLap.racer_id) {
          style = { color: 'green' };
        } else if (fastestLap.number === i + 1) {
          style = { color: 'red' };
        }

        return <span style={style}>{lapTime}</span>;
      },
    };
  });
};

const generateColumns = ({ stage, racers }) => [{
  Header: '',
  accessor: 'showOnGraph',
  // eslint-disable-next-line
  Cell: ({ original: { showOnGraph } }) => <input type="checkbox" checked={showOnGraph} />,
}, {
  Header: 'Имя',
  accessor: 'name',
}, {
  Header: 'Номер',
  accessor: 'number',
}, ...generateLapsColumns({ stage, racers }), {
  id: 'totalTime',
  Header: 'Общее время',
  accessor: ({ id: racerId }) => {
    const { laps } = findRacer({ racers, racerId });
    return { totalLaps: laps.length, totalTime: sumBy(laps, 'time') };
  },
  Cell: ({ original: { id: racerId } }) => timeToHuman(findRacer({ racers, racerId }).totalTime),
  sortMethod: (a, b) => {
    if (a.totalLaps === b.totalLaps) {
      return a.totalTime < b.totalTime ? 1 : -1;
    }
    return a.totalLaps < b.totalLaps ? -1 : 1;
  },
}];


const mapResultToProps = ({ data }) => {
  const { loading } = data;
  if (!data.stage) return { loading };

  const { stage: { racers, laps, ...stage } } = data;

  const preparedStage = prepareStage({ stage, laps });
  const preparedRacers = prepareRacers({ racers, laps });
  const klasses = racers.map(r => r.klass);

  return {
    stage: preparedStage,
    racers: preparedRacers,
    laps,
    klasses,
    loading,
  };
};

const mapPropsToOptions = ({ match }) => ({
  variables: { id: match.params.id },
});


const StagesIndexTable = ({ stage, racers, laps, klasses, loading }) => {
  if (loading) return null;

  return (
    <Table
      columns={generateColumns({ stage, racers })}
      data={racers}
      defaultSorted={[{ id: 'totalTime', desc: true }]}
    />
  );
};

export default graphql(GetStage, {
  props: mapResultToProps,
  options: mapPropsToOptions,
})(withRouter(StagesIndexTable));
