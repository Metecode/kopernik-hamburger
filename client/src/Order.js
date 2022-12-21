import "./App.css";
import Card from "./Components/Card";
import Dropdown from "./Components/Dropdown";
import { useEffect, useState } from "react";
import axios from "axios";
import Navbar from "./Components/Navbar";
import { Button } from 'react-bootstrap';
import 'bootstrap/dist/css/bootstrap.css';

function Order(props) {
  const [sayac, setSayac] = useState(0);
  const [et, setEt] = useState("Et turu seciniz");
  const [ekmek, setEkmek] = useState("Ekmek turu seciniz");
  const [sos, setSos] = useState("Sos turu seciniz");
  const [hamburgerSecenegi, sethamburgerSecenegi] = useState(
    "Hamburger cesidini seciniz"
  );
  const [icecek, setIcecek] = useState("İcecek seciniz");
  const [tatli, setTatli] = useState("Tatli seciniz");
  const [etOption, setEtOption] = useState([]);
  const [ekmekOption, setEkmekOption] = useState([]);
  const [sosOption, setSosOption] = useState([]);
  const [hamburgerSecenegiOption, sethamburgerSecenegiOption] = useState([]);
  const [icecekOption, setIcecekOption] = useState([]);
  const [tatliOption, setTatliOption] = useState([]);
  const [id, setId] = useState(0);
  const [etFiyatlari, setEtFiyatlari] = useState([]);
  const [hamburgerFiyatlari, setHamburgerFiyatlari] = useState([]);

  const [price, setPrice] = useState([]);
  const [count, setCount] = useState(1);
  const [resim, setResim] = useState("1.jpg");
  const [num, setNum] = useState(0);
  const [sosId, setSosId] = useState();
  const [ekmekId, setEkmekId] = useState([]);
  const [et_Id, setEtId] = useState();
  const [hamburgerId, setHamburgerId] = useState();
  const [icecekId, setIcecekId] = useState();
  const [tatliId, setTatliId] = useState();
  const[totalHamburger, setTotalHamburger] = useState();
  useEffect(() => {
    if (sayac == 0) {
      axios
        .get("http://localhost:3000/api/v1/ekmek/")
        .then((res) => {
        
          setEkmekId(res.data);
          res.data.map((item) => {
            ekmekOption.push(`${item.ekmek_id} ${item.ekmek_turu}`);
          });
        })
        .catch((err) => console.log(err));
      axios
        .get("http://localhost:3000/api/v1/hamburger_secenekleri/")
        .then((res) => {
          setHamburgerFiyatlari(res.data);
          res.data.map((item) => {
            hamburgerSecenegiOption.push(
              `${item.hamburger_secenek_id} ${item.hamburger_secenegi}`
            );
          });
        })
        .catch((err) => console.log(err));
      axios
        .get("http://localhost:3000/api/v1/sos/")
        .then((res) => {
          setSosId(res.data);
          res.data.map((item) => {
            sosOption.push(`${item.sos_id} ${item.sos_turu}`);
          });
        })
        .catch((err) => console.log(err));
      axios
        .get("http://localhost:3000/api/v1/icecek/")
        .then((res) => {
          setIcecekId(res.data);
          res.data.map((item) => {
            icecekOption.push(`${item.icecek_id} ${item.icecek_ismi}`);
          });
        })
        .catch((err) => console.log(err));
      axios
        .get("http://localhost:3000/api/v1/tatli/")
        .then((res) => {
          setTatliId(res.data);
          res.data.map((item) => {
            tatliOption.push(`${item.tatli_id} ${item.tatli_ismi}`);
          });
        })
        .catch((err) => console.log(err));
    }
    setSayac(1);
  }, []);

  useEffect(() => {
    if (sayac == 0) {
      axios
        .get("http://localhost:3000/api/v1/et/")
        .then((res) => {
          res.data.map((item) => {
            etOption.push(
              `${item.et_id} ${item.pisme_turu} ${item.et_turu} ${item.gramaj} ${item.gramaj_fiyat} tl`
            );
            setEtFiyatlari(res.data);
          });
        })
        .catch((err) => console.log(err));
    }
    setSayac(1);
  }, []);

  useEffect(() => {
    let hamburgerFiyat = 0,
      etFiyat = 0;
     

    let etId = et.substring(0, et.indexOf(" "));

    if (etId != "Et") {
      etFiyat = etFiyatlari.filter((et) => {
        return et.et_id == etId;
      })[0].gramaj_fiyat;
      setEtId(etId);
    }
    let hamburgerId = hamburgerSecenegi.substring(
      0,
      hamburgerSecenegi.indexOf(" ")
    );
    if (hamburgerId != "Hamburger") {
      hamburgerFiyat = hamburgerFiyatlari.filter((hamburgerSecenegi) => {
        return hamburgerSecenegi.hamburger_secenek_id == hamburgerId;
      })[0].hamburger_fiyat;
      setResim(`${hamburgerId}.jpg`);
      setHamburgerId(hamburgerId);
    }
    setPrice(hamburgerFiyat + etFiyat);
    
    let ekmek_Id = ekmek.substring(0, ekmek.indexOf(" "));
    setEkmekId(ekmek_Id);


    let sos_Id = sos.substring(0, sos.indexOf(" "));

    setSosId(sos_Id);

    let icecek_Id = icecek.substring(0, icecek.indexOf(" "));

  
      setIcecekId(icecek_Id);
    
    let tatli_Id = tatli.substring(0, tatli.indexOf(" "));

      setTatliId(tatli_Id);
    
  }, [et, hamburgerSecenegi, ekmek, sos, icecek, tatli]);


 const addCart = async() => {
    let hamburgerOrder =null;
      await axios 
        .post("http://localhost:3000/api/v1/hamburger/", {
          sos_id: sosId,
          et_id: et_Id,
          ekmek_id: ekmekId,
          hamburger_miktar: count,
          hamburger_secenek_id:hamburgerId,
        })
        .then((res) => { 
          // console.log(res);
          hamburgerOrder = res.data;
        }) 
        console.log(hamburgerOrder)
      let {data} = await axios
        .post("http://localhost:3000/api/v1/siparis_urunler/",{
          hamburger_id: hamburgerOrder.hamburger_id,
          tatli_id: tatliId,
          icecek_id:icecekId,
          fiyat: price,
        })
        console.log(data);
        props.handleClick(data);
  };

  return (
    <div className="">
      <div className="App">
        <div className="container">
          <Card
            image={resim}
            name={hamburgerSecenegi}
            price={price}
            count={count}
            setCount={setCount}
          />
        </div>
        <div className="dropdown">
          <section>
            <Dropdown
              selected={ekmek}
              setSelected={setEkmek}
              options={ekmekOption}
            />
          </section>
          <section>
            <Dropdown selected={et} setSelected={setEt} options={etOption} />
          </section>
          <section>
            <Dropdown selected={sos} setSelected={setSos} options={sosOption} />
          </section>
          <section>
            <Dropdown
              selected={hamburgerSecenegi}
              setSelected={sethamburgerSecenegi}
              options={hamburgerSecenegiOption}
            />
          </section>
          <section>
            <Dropdown
              selected={icecek}
              setSelected={setIcecek}
              options={icecekOption}
            />
          </section>
          <section>
            <Dropdown
              selected={tatli}
              setSelected={setTatli}
              options={tatliOption}
            />
          </section>
          <Button variant="primary" size="lg" onClick={addCart}>Sepete Ekle</Button>
        </div>
      </div>
    </div>
  )
}

export default Order