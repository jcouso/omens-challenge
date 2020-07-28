import React, { useState, useEffect } from 'react'
import { HomeTitle, FilterWrapper } from './styled'
import { CarCard } from '../../componets/car-card'
import { Container, Row, Col } from 'react-bootstrap'
import { Select } from '../../componets/select'
import { api } from '../../services/api'

export default function Home() {
  const [selectedDurationDays, setSelectedDurationDays] = useState('')
  const [selectedDistance, setSelectedDistance] = useState('')
  const [cars, setCars] = useState([])

  useEffect(() => {
    const fetchCars = async () => {
      const query = new URLSearchParams()

      if (selectedDistance && selectedDistance.length) {
        query.append('distance', selectedDistance)
      }

      if (selectedDurationDays && selectedDurationDays.length) {
        query.append('duration', selectedDurationDays)
      }

      const { data } = await api.get('/cars.json?' + query.toString())

      setCars(data)
    }

    fetchCars()
  }, [selectedDistance, selectedDurationDays])

  return (
    <Container>
      <HomeTitle>Welcome to GetAround</HomeTitle>

      <FilterWrapper>
        <Select
          options={Array.from(Array(30), (_, i) => i + 1)}
          label='Duration (in days)'
          onChange={event => {
            setSelectedDurationDays(event.target.value)
          }}
        />
        <Select
          options={Array.from(Array(60), (_, i) => (i + 1) * 50)}
          label='Distance (in kms)'
          onChange={event => setSelectedDistance(event.target.value)}
        />
      </FilterWrapper>
      <Row>
        {cars &&
          cars.map((car, index) => (
            <Col xs={12} sm={12} md={6} key={index}>
              <CarCard car={car} />
            </Col>
          ))}
      </Row>
    </Container>
  )
}
