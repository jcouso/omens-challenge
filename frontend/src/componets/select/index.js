import React from 'react'
import { SelectWrapper } from './styled'

export const Select = ({ options, label, onChange }) => {
  return (
    <SelectWrapper onChange={onChange}>
      <label>{label}</label>
      <select>
        <option value=''></option>
        {options.map(option => {
          return (
            <option key={option} value={option}>
              {option}
            </option>
          )
        })}
      </select>
    </SelectWrapper>
  )
}
