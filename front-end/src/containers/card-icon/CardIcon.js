import React from 'react'
import './style.css'
export default function CardIcon({name,img}) {
  return (
    <div className="card-icon">
        <div className="image">
            <img src={img} alt=""></img>
        </div>
        <p className="name">{name}</p>
    </div>
  )
}
