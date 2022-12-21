const getHamburger = "SELECT * FROM hamburger";
const getHamburgerById = "SELECT * FROM hamburger WHERE hamburger_id = $1";
const checkHamburgerTuruExists =
  "SELECT s FROM hamburger s WHERE s.hamburger_id = $1";
const addHamburger =
  "INSERT INTO hamburger (sos_id,et_id,ekmek_id,hamburger_miktar,hamburger_secenek_id) VALUES ($1, $2, $3, $4, $5) RETURNING * ";
const removeHamburger = "DELETE FROM hamburger WHERE hamburger_id = $1";
const updateHamburger = "UPDATE hamburger SET hamburger_miktar = $1 WHERE hamburger_id = $2";
const getEkmek = "SELECT * FROM ekmek";
const getEkmekById = "SELECT * FROM ekmek WHERE ekmek_id = $1";
const getEt = "SELECT * FROM et";
const getEtById = "SELECT * FROM et WHERE et_id = $1";
const getSos = "SELECT * FROM sos";
const getSosById = "SELECT * FROM et WHERE et_id = $1";
const getHamburgerSecenekleri = "SELECT * FROM hamburger_secenekleri";
const getHamburgerSecenekleriById =
  "SELECT * FROM hamburger_secenekleri WHERE hamburger_secenek_id = $1";
const getIcecek = "SELECT * FROM icecek";
const getIcecekById = "SELECT * FROM icecek WHERE icecek_id = $1";
const getTatli = "SELECT * FROM tatli";
const getTatliById = "SELECT * FROM tatli WHERE tatli_id = $1";
const getSiparis_urunler = "SELECT * FROM siparis_urunler";
const getSiparis_urunlerById =
  "SELECT * FROM siparis_urunler WHERE kayit_no = $1";
const addSiparis_urunler =
  "INSERT INTO  siparis_urunler (hamburger_id,icecek_id,tatli_id,fiyat) VALUES ($1,$2,$3,$4);";
const addSiparis_totalurunler =
  "SELECT * FROM siparis_urunler INNER JOIN icecek ON siparis_urunler.icecek_id = icecek.icecek_id INNER JOIN tatli ON siparis_urunler.tatli_id = tatli.tatli_id INNER JOIN hamburger ON hamburger.hamburger_id = siparis_urunler.hamburger_id ORDER BY kayit_no DESC LIMIT 1";
const removeSiparis_urunler = "DELETE FROM siparis_urunler WHERE kayit_no = $1";
const updateSiparis_urunler = "UPDATE siparis_urunler SET fiyat = $1 WHERE kayit_no = $2";
const addSiparis =
  "INSERT INTO siparis (musteri_id,odeme_id,teslimat_id,personel_id,sube_id,toplam_tutar,kayit_no) VALUES ($1, $2, $3, $4, $5, $6, $7) RETURNING * ";
module.exports = {
  getHamburger,
  getHamburgerById,
  checkHamburgerTuruExists,
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
  addSiparis_totalurunler,
  removeSiparis_urunler,
  updateSiparis_urunler,
  addSiparis,
};
