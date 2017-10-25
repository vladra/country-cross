import React from 'react';
import PropTypes from 'prop-types';
import ReactTable from 'react-table';

import 'react-table/react-table.css';

const defaultOptions = {
  showPagination: false,
  showPageSizeOptions: false,
  previousText: 'Назад',
  nextText: 'Вперед',
  loadingText: 'Загрузка...',
  noDataText: 'Данные не найдены',
  pageText: 'Страница',
  ofText: 'из',
  rowsText: 'строк',
};

const Table = ({
  columns = [],
  data = [],
  ...props
}) => {
  const defaultPageSize = data ? data.length : 10;

  return (
    <ReactTable
      columns={columns}
      data={data}
      defaultPageSize={defaultPageSize}
      {...defaultOptions}
      {...props}
    />
  );
};

Table.propTypes = {
  columns: PropTypes.arrayOf(PropTypes.object).isRequired,
  data: PropTypes.arrayOf(PropTypes.object).isRequired,
};

export default Table;
