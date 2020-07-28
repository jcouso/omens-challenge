import { useEffect, useState, useRef } from 'react'
import { api } from '../services/api'

export default function useFetch(url, options = {}) {
  const isCurrent = useRef(true)
  const [state, setState] = useState({ data: null, error: null, loading: true })

  useEffect(() => {
    return () => {
      isCurrent.current = false
    }
  }, [])

  useEffect(() => {
    setState({ ...state, loading: true })
    const fetch = async () => {
      try {
        const { data } = await api.get(url, options)
        if (isCurrent.current) setState({ ...state, data, loading: false })
      } catch (error) {
        if (isCurrent.current) setState({ error, data: null, loading: false })
      }
    }

    fetch()
  }, [])

  return state
}
