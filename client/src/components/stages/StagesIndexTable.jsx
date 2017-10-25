import React from 'react';
import PropTypes from 'prop-types';
import { graphql } from 'react-apollo';
import { Link } from 'react-router-dom';

import { FetchStages } from 'gql/queries';
import { Table } from 'components/Table';

const columns = [{
  Header: 'Название',
  accessor: 'name',
}, {
  Header: 'Локация',
  accessor: 'location',
}, {
  Header: 'Дата',
  accessor: 'date',
}, {
  // eslint-disable-next-line
  Cell: ({ original }) => <Link to={`/stages/${original.id}`}>Детали</Link>,
  sortable: false,
}];

const mapResultToProps = ({ data }) => {
  const { loading } = data;
  if (!data.all_stages) return { loading };

  const { all_stages: stages } = data;

  return { stages, loading };
};

const StagesIndexTable = ({ stages, loading }) => {
  if (loading) return null;

  return (
    <Table
      columns={columns}
      data={stages}
    />
  );
};

StagesIndexTable.propTypes = {
  stages: PropTypes.arrayOf(PropTypes.object).isRequired,
  loading: PropTypes.bool.isRequired,
};

StagesIndexTable.defaultProps = {
  stages: [],
};

export default graphql(FetchStages, {
  props: mapResultToProps,
})(StagesIndexTable);
