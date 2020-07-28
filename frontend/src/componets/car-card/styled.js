import styled from 'styled-components'

export const CardWrapper = styled.div`
  border: 1px solid lightgray;
  border-radius: 4px;
  cursor: pointer;
  margin: 2rem;
  box-shadow: none;

  transition: box-shadow 0.3s linear;

  &:hover {
    box-shadow: rgba(0, 0, 0, 0.1) 0px 0px 0px 0px, rgba(0, 0, 0, 0.1) 0px 2px 20px 0px;
  }
`

export const CardInfoWrapper = styled.div`
  display: flex;
  flex-direction: column;
`

export const CarInfo = styled.div`
  display: flex;
  justify-content: space-between;
  padding: 0.5rem;
`

export const CarInfoLabel = styled.span`
  font-weight: 800;
`

export const ImageCard = styled.div`
  background-image: url(${props => props.src});
  background-position: center;
  background-repeat: no-repeat;
  background-size: fit;
  height: 250px;
  width: 100%;
`

export const CardInfoItem = styled.div``
