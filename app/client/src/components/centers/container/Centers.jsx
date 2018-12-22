import React from 'react';
import axios from 'axios';
import CentersList from '../presentation/CentersList';

class Centers extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      centers: []
    };
  }

  componentDidMount() {
    axios.get('/api/v1/centers')
      .then((response) => {
        // console.log(response.data.data);
        this.setState({
          centers: response.data.data.centers
        });
      })
      .catch((error) => {
        console.log(error);
      });
  }

  render() {
    return (
      <div className="columns is-multiline">
        <CentersList centers={this.state.centers} />
      </div>
    );
  }
}

export default Centers;