import axios from "axios";
import React, { useState, useEffect } from "react";
import "./Cart.css"
import swal from 'sweetalert';

const Cart = ({ cart, setCart, handleChange }) => {
  const [price, setPrice] = useState(0);
  const [num, setNum] = useState(1);
  const handleRemove = (kayit_no) => {
    const arr = cart.filter((item) => item.kayit_no !== kayit_no);
    setCart(arr);
    handlePrice();
    axios
    .delete(`http://localhost:3000/api/v1/siparis_urunler/${kayit_no}`)
    .then((response) => response.data)
    .catch((error) => console.error(error))
  };

  const handlePrice = () => {
    let ans = 0;
    cart.map((item) => (ans += item.hamburger_miktar * item.fiyat + item.tatli_fiyat + item.icecek_fiyat));
    setPrice(ans);
  };

  useEffect(() => {
    handlePrice();
  });
  function randomNumberInRange(min, max) {
    // 👇️ get number between min (inclusive) and max (inclusive)
    return Math.floor(Math.random() * (max - min + 1)) + min;
  }
  
  const handleOkay = async(miktar, fiyat, kayit_no,icecek,tatli)=>{
    swal({
      title: "Afiyet olsun siparisin hazirlaniyor!",
      text: "Siparis Onaylandi",
      icon: "success",
      button: "Devam et",
    });
    setNum(randomNumberInRange(1, 2));
    await axios
    .post("http://localhost:3000/api/v1/siparis/", {
      musteri_id:num,
      odeme_id:num,
      teslimat_id:num,
      personel_id:num,
      sube_id:num,
      toplam_tutar: fiyat*miktar+icecek+tatli,
      kayit_no: kayit_no,
    })
  }
  
 console.log(cart);
  return (
    <article>
      {cart.map((item) => (
        <div className="cart_box" key={item.hamburger_id}>
          <div className="cart_img">
            <img src= {`${item.hamburger_secenek_id}.jpg`}  alt="" />
            <p>{item.icecek_ismi} {item.icecek_fiyat}₺</p>
            <p>{item.tatli_ismi} {item.tatli_fiyat}₺</p>
          </div>
          <div>
            <h3>hamburger miktari guncelle </h3>
            <button onClick={() => handleChange(item, 1)}>+</button>
            <button>{item.hamburger_miktar}</button>
            <button onClick={() => handleChange(item, -1)}>-</button>
          </div>
          <div>
            <span>{`${item.fiyat * item.hamburger_miktar}`}₺</span>
            <button onClick={() => handleRemove(item.kayit_no)}>Sepeti Sil</button>
          <button className="okay" onClick={()=> handleOkay(item.hamburger_miktar,item.fiyat,item.kayit_no,item.icecek_fiyat,item.tatli_fiyat)}  >Siparisi Onayla</button>
          </div>
        </div>
      ))}
      <div className="total">
        <span>Toplam Tutar</span>
        <span>{price} ₺</span>
      </div>
    </article>
  );
};

export default Cart;