const pool = require("../../db");
const queries = require("./queries");

const getHamburger = (req, res) => {
  pool.query(queries.getHamburger, (error, results) => {
    if (error) throw error;
    res.status(200).json(results.rows);
  });
};

const getHamburgerById = (req, res) => {
  const id = parseInt(req.params.id);
  pool.query(queries.getHamburgerById, [id], (error, results) => {
    if (error) throw error;
    res.status(200).json(results.rows);
  });
};

const addHamburger = (req, res) => {
  const { sos_id, et_id, ekmek_id, hamburger_miktar, hamburger_secenek_id } =
    req.body;

  pool.query(
    queries.addHamburger,
    [sos_id, et_id, ekmek_id, hamburger_miktar, hamburger_secenek_id],
    (error, results) => {
      if (error) throw error;
      res.status(201).send(results.rows[0]);
      console.log("Hamburger create");
    }
  );
};

const removeHamburger = (req, res) => {
  const hamburger_id = parseInt(req.params.hamburger_id);

  pool.query(queries.getHamburgerById, [hamburger_id], (error, results) => {
    const noSosFound = !results.rows.length;
    if (noSosFound) {
      res.send("Hamburger does not exist in the database");
    }

    pool.query(queries.removeHamburger, [hamburger_id], (error, results) => {
      if (error) throw error;
      res.status(200).send("Hamburger removed successfully.");
    });
  });
};

const updateHamburger = async(req, res) => {
  const { hamburger_miktar , hamburger_id } = req.body;
  await pool.query(
      queries.updateHamburger,
      [ hamburger_miktar,hamburger_id],
      (error, results) => {
        if (error) throw error;
        res.status(200).send("Hamburger turu updated successfully");
      }
    );
};

const getEkmek = (req, res) => {
  pool.query(queries.getEkmek, (error, results) => {
    if (error) throw error;
    res.status(200).json(results.rows);
  });
};

const getEkmekById = (req, res) => {
  const ekmek_id = parseInt(req.params.id);
  pool.query(queries.getEkmekById, [ekmek_id], (error, results) => {
    if (error) throw error;
    res.status(200).json(results.rows);
  });
};

const getEt = (req, res) => {
  pool.query(queries.getEt, (error, results) => {
    if (error) throw error;
    res.status(200).json(results.rows);
  });
};

const getEtById = (req, res) => {
  const et_id = parseInt(req.params.id);
  pool.query(queries.getEtById, [et_id], (error, results) => {
    if (error) throw error;
    res.status(200).json(results.rows);
  });
};

const getSos = (req, res) => {
  pool.query(queries.getSos, (error, results) => {
    if (error) throw error;
    res.status(200).json(results.rows);
  });
};

const getSosById = (req, res) => {
  const et_id = parseInt(req.params.id);
  pool.query(queries.getEtById, [et_id], (error, results) => {
    if (error) throw error;
    res.status(200).json(results.rows);
  });
};

const getHamburgerSecenekleri = (req, res) => {
  pool.query(queries.getHamburgerSecenekleri, (error, results) => {
    if (error) throw error;
    res.status(200).json(results.rows);
  });
};

const getHamburgerSecenekleriById = (req, res) => {
  const hambuger_secenekleri_id = parseInt(req.params.id);
  pool.query(
    queries.getHamburgerSecenekleriById,
    [hambuger_secenekleri_id],
    (error, results) => {
      if (error) throw error;
      res.status(200).json(results.rows);
    }
  );
};

const getIcecek = (req, res) => {
  pool.query(queries.getIcecek, (error, results) => {
    if (error) throw error;
    res.status(200).json(results.rows);
  });
};

const getIcecekById = (req, res) => {
  const icecek_id = parseInt(req.params.id);
  pool.query(queries.getIcecekById, [icecek_id], (error, results) => {
    if (error) throw error;
    res.status(200).json(results.rows);
  });
};

const getTatli = (req, res) => {
  pool.query(queries.getTatli, (error, results) => {
    if (error) throw error;
    res.status(200).json(results.rows);
  });
};

const getTatliById = (req, res) => {
  const tatli_id = parseInt(req.params.id);
  pool.query(queries.getTatliById, [tatli_id], (error, results) => {
    if (error) throw error;
    res.status(200).json(results.rows);
  });
};

const getSiparis_urunler = (req, res) => {
  pool.query(queries.getSiparis_urunler, (error, results) => {
    if (error) throw error;
    res.status(200).json(results.rows);
  });
};

const getSiparis_urunlerById = (req, res) => {
  const kayit_no = parseInt(req.params.id);
  pool.query(queries.getSiparis_urunlerById, [kayit_no], (error, results) => {
    if (error) throw error;
    res.status(200).json(results.rows);
  });
};

const addSiparis_urunler = async (req, res) => {
  const { hamburger_id, icecek_id, tatli_id, fiyat } = req.body;

  await pool.query(
    queries.addSiparis_urunler,
    [hamburger_id, icecek_id, tatli_id, fiyat],
    (error, results) => {
      if (error) throw error;
    }
  );
  await pool.query(queries.addSiparis_totalurunler, [], (error, results) => {
    if (error) throw error;
    res.status(201).send(results.rows[0]);
  });
};
const removeSiparis_urunler = (req, res) => {
  const kayit_no = parseInt(req.params.kayit_no);

  pool.query(queries.getSiparis_urunlerById, [kayit_no], (error, results) => {
    const noSiparisFound = !results.rows.length;
    if (noSiparisFound) {
      res.send("Siparis does not exist in the database");
    }

    pool.query(queries.removeSiparis_urunler, [kayit_no], (error, results) => {
      if (error) throw error;
      res.status(200).send("Siparis removed successfully.");
    });
  });
};

const updateSiparis_urunler = async (req, res) => {
  const { fiyat, kayit_no } = req.body;
  await pool.query(
    queries.updateSiparis_urunler,
    [fiyat, kayit_no],
    (error, results) => {
      if (error) throw error;
      res.status(200).send("Siparis turu updated successfully");
    }
  );
};

const addSiparis = async (req, res) => {
  const {musteri_id, odeme_id, teslimat_id, personel_id, sube_id, toplam_tutar, kayit_no} = req.body;

    await pool.query(queries.addSiparis, [musteri_id, odeme_id, teslimat_id, personel_id, sube_id, toplam_tutar, kayit_no], (error, results) => {
      if (error) throw error;    
    }); 
};
module.exports = {
  getHamburger,
  getHamburgerById,
  addHamburger,
  removeHamburger,
  updateHamburger,
  getEkmek,
  getEkmekById,
  getEt,
  getEtById,
  getSos,
  getSosById,
  getHamburgerSecenekleri,
  getHamburgerSecenekleriById,
  getIcecek,
  getIcecekById,
  getTatli,
  getTatliById,
  getSiparis_urunler,
  getSiparis_urunlerById,
  addSiparis_urunler,
  removeSiparis_urunler,
  updateSiparis_urunler,
  addSiparis,
};
