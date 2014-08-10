

function fbs_click() {
    var url = location.protocol + "//" + location.hostname + "/mooncake2014/index.html";
   // alert(url);
  //  alert(encodeURIComponent(url));
    window.open('http://www.facebook.com/sharer.php?u=' + encodeURIComponent( url), 'sharer', 'toolbar=0,status=0,width=626,height=436');
    return false;
}

function btnActivityClick()
{
    location.href = "index.html";
}
function btnIssaBelleClick() {
    location.href = "isabelle.html";
}
function btnEmperorClick() {
    location.href = "emperor.html";
}
function btnPresentClick() {
    location.href = "mode.html";
}
function btnStoresClick() {
    location.href = "store.html";
}
function btnListClick() {
    location.href = "winners.html";
}
function btnFBIssabelleClick() {
    window.open("https://www.facebook.com/isabelle.tw?fref=ts");
}
function btnFBEmperorClick() {
    window.open("https://www.facebook.com/emperorfood?fref=ts");
}
function btnLogoIsabelleClick() {
    window.open("http://www.isabelle.com.tw/");
}
function btnLogoEmperorClick() {
    window.open("http://www.emperorfood.com.tw/");
}
