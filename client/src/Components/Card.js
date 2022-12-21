import React, { useState } from "react";
import "./Card.css";
function Card(props) {
  const handleSubtractOne = () => {
    if(props.count>0){
      props.setCount(props.count - 1);
    }
  };

  const handleAddOne = () => {
    props.setCount(props.count + 1);
  };
  return (
    <div className="productList">
      <div key={props.id} className="productCard">
        <img src={props.image} alt="product-img" className="productImage"></img>

        <div className="productCard__content">
          <h3 className="productName">{props.name}</h3>
          <div className="displayStack__1">
            <div className="productPrice">{props.price * props.count}₺</div>
            <div className="hamburger-count">
            <p>Adet: {props.count}</p>
              <button onClick={ handleSubtractOne} text="-">-</button>
              <button onClick={handleAddOne} text="+">+</button>
            </div>
          </div>
          <div className="displayStack__2"></div>
        </div>
      </div>
    </div>
  );
}

export default Card;
