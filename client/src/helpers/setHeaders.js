import axios from 'axios';
const api = axios.create({
  baseURL: 'http://localhost:3001'
});

const setHeaders = (token) => {
  api.interceptors.request.use((config) => {
    config.headers.Authorization = `Bearer ${token}`;
    return config;
  });
};

export default setHeaders;
