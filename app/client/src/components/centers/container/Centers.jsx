import React from 'react';
import axios from 'axios';
import { connect } from 'react-redux';
import CentersList from '../presentation/CentersList';
import * as centerActions from '../../../actions/centerActions';


class Centers extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      centers: []
    };
  }

  // componentDidMount() {
  //   axios.get('/api/v1/centers')
  //     .then((response) => {
  //       // console.log(response.data.data);
  //       this.setState({
  //         centers: response.data.data.centers
  //       });
  //     })
  //     .catch((error) => {
  //       console.log(error);
  //     });
  // }

  render() {
    return (
      <div className="columns is-multiline">
        <CentersList centers={this.props.centers} />
      </div>
    );
  }
}

function mapStateToProps(state, ownProps) {
  return {
    centers: state.centers.centers
  };
}

export default connect(mapStateToProps)(Centers);
