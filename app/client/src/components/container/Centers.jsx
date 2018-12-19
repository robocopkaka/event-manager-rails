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
          .then(response => {
              // console.log(response.data.data)
              this.setState({
                  centers: response.data.data.centers
              });
          })
          .catch(error =>{
              console.log(error)
          });
    }

    render() {
      return (
        <div className="columns">
          {/*{this.state.centers.map(center => {*/}
            {/*console.log(center)*/}
            {/*return (*/}
                {/*<div className="column">*/}
                    {/*<CentersList*/}
                      {/*key={center.id}*/}
                      {/*center={center}*/}
                    {/*/>*/}
                {/*</div>*/}
            {/*);*/}
          {/*})}*/}
          <CentersList centers={this.state.centers}  />
        </div>
      );
    }
}

export default Centers;