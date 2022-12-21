import "./App.css";
import { useEffect, useState } from "react";
import Navbar from "./Components/Navbar";
import "bootstrap/dist/css/bootstrap.css";
import Order from "./Order";
import Cart from "./Cart";
import axios from "axios";
function App() {
  const [show, setShow] = useState(true);
  const [cart, setCart] = useState([]);
  const handleClick = (item) => {
    if (cart.indexOf(item) !== -1) return;
    setCart([...cart, item]);
  };

  const handleChange = async(item, d) => {
    const ind = cart.indexOf(item);
    let arr = cart;
    arr[ind].hamburger_miktar += d;
    console.log(arr[ind].hamburger_miktar)
    if (arr[ind].hamburger_miktar === 0) arr[ind].hamburger_miktar = 1;
    setCart([...arr]);
   await axios
    .put(`http://localhost:3000/api/v1/siparis_urunler`,{
      kayit_no:item.kayit_no,
      fiyat: arr[ind].hamburger_miktar * item.fiyat + item.tatli_fiyat + item.icecek_fiyat,
    })
    .then((res) => { 
     console.log(res);
    }) 
    await axios
    .put(`http://localhost:3000/api/v1/hamburger`,{
      hamburger_id:item.hamburger_id,
      hamburger_miktar:arr[ind].hamburger_miktar
    })
    .then((res) => { 
     console.log(res);
    }) 
  }; 
  return (
    <div className="">
      <Navbar count={cart.length} setShow={setShow}></Navbar>
      {show ? (
        <Order handleClick={handleClick} />
      ) : (
        <Cart cart={cart} setCart={setCart} handleChange={handleChange}    />
      )}
    </div>
  );
}

export default App;

//z-index

// {contents.map((contents) => (
//   <Card
//     key={contents.id}
//     image={contents.image}
//     name={contents.name}
//     price={contents.price}
//     totalSales={contents.totalSales}
//   />
// ))}
