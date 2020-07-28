import React from 'react'
import { HomeTitle, CardsWrapper } from './styled'
import { useFetch } from '../../hooks'
import { CarCard } from '../../componets/car-card'
import { Container, Row, Col } from 'react-bootstrap'

export default function Home() {
  const { data: cars, error, loading } = useFetch('/cars.json')
  return (
    <Container>
      <HomeTitle>Welcome to GetAround</HomeTitle>

      <Row>
        {cars &&
          cars.map((car, index) => (
            <Col xs={6}>
              <CarCard key={index} car={car} />
            </Col>
          ))}
      </Row>
    </Container>
  )
}
