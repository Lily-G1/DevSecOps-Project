// src/axios.js
import axios from 'axios';

// Use environment variable if set, otherwise use relative paths
const API_BASE_URL = '';

const instance = axios.create({
  baseURL: API_BASE_URL,
});

instance.interceptors.request.use((config) => {
  const token = localStorage.getItem('token');
  if (token) config.headers['Authorization'] = `Bearer ${token}`;
  return config;
});

export default instance;
