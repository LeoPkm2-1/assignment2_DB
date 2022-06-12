import React from 'react'
import './style.css'
export default function Card({name,price,img}) {
  return (
    <div class="card">
        <img src={img} alt=""></img>
        <div class="group">
            <p class="name">
                {name}
            </p>
            <div class="bottom">
                <p class="price">
                    {price}.000đ
                </p>
                <i class="fa-solid fa-plus"></i>
            </div>
        </div>
    </div>
  )
}
