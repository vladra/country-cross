import { gql } from 'react-apollo';

const FetchStages = gql`
  query {
    all_stages {
      id
      name
      date
    }
  }
`;


const GetStage = gql`
  query {
    stage(id: $id) {
      id
      name
      date
      laps_amount
      lap_distance
      laps { id number time time_h racer_id }
      racers { id name number klass vehicle { id name }}
    }
  }
`;

export { FetchStages, GetStage };
