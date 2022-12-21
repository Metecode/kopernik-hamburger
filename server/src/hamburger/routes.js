const { Router } = require("express");
const controller = require("./controller");

const router = Router();

router.get("/api/v1/hamburger", controller.getHamburger);
router.post("/api/v1/hamburger", controller.addHamburger);
router.get("/api/v1/hamburger/:id", controller.getHamburgerById);
router.put("/api/v1/hamburger", controller.updateHamburger);
router.delete("/api/v1/hamburger/:hamburger_id", controller.removeHamburger);
router.get("/api/v1/ekmek", controller.getEkmek);
router.get("/api/v1/ekmek/:id", controller.getEkmekById);
router.get("/api/v1/et", controller.getEt);
router.get("/api/v1/et/:id", controller.getEtById);
router.get("/api/v1/sos", controller.getSos);
router.get("/api/v1/sos/:id", controller.getSosById);
router.get("/api/v1/hamburger_secenekleri", controller.getHamburgerSecenekleri);
router.get("/api/v1/hamburger_secenekleri/:id", controller.getHamburgerSecenekleriById);
router.get("/api/v1/icecek", controller.getIcecek);
router.get("/api/v1/icecek/:id", controller.getIcecekById);
router.get("/api/v1/tatli", controller.getTatli);
router.get("/api/v1/tatli/:id", controller.getTatliById);
router.get("/api/v1/siparis_urunler", controller.getSiparis_urunler);
router.post("/api/v1/siparis_urunler", controller.addSiparis_urunler);
router.delete("/api/v1/siparis_urunler/:kayit_no", controller.removeSiparis_urunler);
router.get("/api/v1/siparis_urunler/:id", controller.getSiparis_urunlerById);
router.put("/api/v1/siparis_urunler", controller.updateSiparis_urunler);
router.post("/api/v1/siparis", controller.addSiparis);

module.exports = router;


