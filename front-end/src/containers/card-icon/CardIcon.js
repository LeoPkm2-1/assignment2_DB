import React from 'react'
import './style.css'
export default function CardIcon({name}) {
  return (
    <div className="card-icon">
        <div className="image">
            <img src="https://minio.thecoffeehouse.com/image/tch-web-order/category-thumbnails/tra-trai-cay-tra-sua.png" alt=""></img>
        </div>
        <p className="name">{name}</p>
    </div>
  )
}
