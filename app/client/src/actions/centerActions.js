import CenterApi from '../api/centerApi';

export function fetchCentersSuccess(centers) {
  return { type: 'FETCH_CENTERS_SUCCESS', centers };
}
export function fetchCenters() {
  console.log(CenterApi)
  return (dispatch) => {
    return CenterApi.getCenters()
      .then((response) => {
        dispatch(fetchCentersSuccess(response.data.data.centers));
      })
      .catch((error) => {
        throw (error);
      });
  };
}
