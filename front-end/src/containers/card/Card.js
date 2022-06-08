import React from 'react'
import './style.css'
export default function Card({name,price,img}) {
  return (
    <div class="card">
        <img src="https://minio.thecoffeehouse.com/image/admin/1639377738_ca-phe-sua-da_400x400.jpg" alt=""></img>
        <div class="group">
            <p class="name">
                {name}
            </p>
            <div class="bottom">
                <p class="price">
                    20.300đ
                </p>
                <i class="fa-solid fa-plus"></i>
            </div>
        </div>
    </div>
  )
}
