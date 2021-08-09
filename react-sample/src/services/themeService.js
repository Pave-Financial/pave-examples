export function toggleTheme(name) {
  detachStylesheets();
  insertStylesheet(name);
}

function detachStylesheets() {
  Array.from(document.querySelectorAll('link[rel="stylesheet"]')).forEach(
    style => {
      style.parentNode.removeChild(style);
    }
  );
}

function insertStylesheet(name) {
  var link = document.createElement("link");
  link.href = "/css/" + name + ".css";
  link.type = "text/css";
  link.rel = "stylesheet";
  document.getElementsByTagName("head")[0].appendChild(link);
}
