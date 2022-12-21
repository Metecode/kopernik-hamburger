import React from "react";
import './Navbar.css';
import { AiOutlineShoppingCart } from "react-icons/ai";
const  Navbar = ({setShow, count}) => {
  return (
    <nav>
      <div className="nav_box">
        <span className="my_restaurant" onClick={()=>setShow(true)}>Kopernik Hamburger</span>
        <div className="cart" onClick={()=>setShow(false)}>
          <span>
          <AiOutlineShoppingCart/>
          </span>
          <span>{count}</span>
        </div>
      </div>
    </nav>
  );
};

export default Navbar;
