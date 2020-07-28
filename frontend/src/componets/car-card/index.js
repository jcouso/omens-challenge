import React from 'react'

import { CardWrapper, ImageCard, CarInfo, CarInfoLabel, CardInfoItem, CardInfoWrapper } from './styled'

export const CarCard = ({ car }) => {
  const { availability, brand, id, model, picturePath, pricePerDay, pricePerKm } = car

  return (
    <CardWrapper>
      <ImageCard src={picturePath} />
      <CarInfo>
        <CardInfoWrapper>
          <CardInfoItem>
            <CarInfoLabel>Brand:</CarInfoLabel> {brand}
          </CardInfoItem>
          <CardInfoItem>
            <CarInfoLabel>Model:</CarInfoLabel> {model}
          </CardInfoItem>
        </CardInfoWrapper>
        <CardInfoWrapper>
          <CardInfoItem>
            <CarInfoLabel>Price per Day: </CarInfoLabel> ${pricePerDay}
          </CardInfoItem>
          <CardInfoItem>
            <CarInfoLabel>Price per Km:</CarInfoLabel> ${pricePerKm}
          </CardInfoItem>
        </CardInfoWrapper>
      </CarInfo>
    </CardWrapper>
  )
}
