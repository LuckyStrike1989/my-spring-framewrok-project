const AES256 = function() {
    this.aesKey = null;
    this.aesIv = null;
    // ASE 256 키 생성
    this.generateAESKey = function() {
        // 키 랜덤 생성
        this.aesKey = CryptoJS.lib.WordArray.random(32);
        // IV 랜덤 생성
        this.aesIv = CryptoJS.lib.WordArray.random(16);
    }
    // 암호화
    this.encrypt = function(plainText) {
        if (this.aesKey != null && this.aesKey != null) {
            return CryptoJS.AES.encrypt(plainText, this.aesKey, {
                   iv: this.aesIv,
                   mode: CryptoJS.mode.CBC,
                   padding: CryptoJS.pad.Pkcs7
               }).toString();
        } else {
            return "";
        }
    }
    // 복호화
    this.decrypt = function(ciphertext) {
        if (this.aesKey != null && this.aesKey != null) {
            const bytes = CryptoJS.AES.decrypt(ciphertext, this.aesKey, {
              iv: this.aesIv,
              mode: CryptoJS.mode.CBC,
              padding: CryptoJS.pad.Pkcs7
            });
            return bytes.toString(CryptoJS.enc.Utf8);
        } else {
            return "";
        }
    }
}