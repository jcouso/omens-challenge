import 'regenerator-runtime/runtime'

import React from 'react'
import ReactDOM from 'react-dom'

import 'bootstrap/dist/css/bootstrap.min.css'
import './index.css'

import { HomePage } from './pages'

const App = () => {
  return <HomePage />
}

ReactDOM.render(<App />, document.getElementById('root'))
