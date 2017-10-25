import { gql } from 'react-apollo';

const FetchStages = gql`
  query FetchStages {
    all_stages {
      id
      name
      date
      location
    }
  }
`;


const GetStage = gql`
  query GetStage($id: ID!) {
    stage(id: $id) {
      id
      name
      date
      laps_amount
      lap_distance
      laps { id number time h_time racer_id }
      racers { id name number klass vehicle { id brand model }}
    }
  }
`;

export { FetchStages, GetStage };
