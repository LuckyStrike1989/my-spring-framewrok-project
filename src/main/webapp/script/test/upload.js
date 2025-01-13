$(function () {
    const documentTypes = ["doc", "docx", "ppt", "pptx", "xls", "xlsx", "hwp", "hwpx"];
    const imageTypes = ["png", "jpg", "jpeg"];
    const videoTypes = ["avi", "mp4", "mov", "wmv"];

    const upload1 = new Transmission_Upload();
    upload1.category = "de175e8df5ad495dbd1570e2a9f80d79"; // test1
    upload1.fileTypes = documentTypes;
    upload1.init("uploadPanel1");

    const upload2 = new Transmission_Upload();
    upload2.category = "61c6e13f475f487a972153ecfa49884d"; // test2
    upload2.fileTypes = imageTypes;
    upload2.init("uploadPanel2");

    const upload3 = new Transmission_Upload();
    upload3.category = "49a96e2f6c474a75af480aa7ea12e257"; // test3
    upload3.fileTypes = videoTypes;
    upload3.init("uploadPanel3");
});
