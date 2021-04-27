if (location.pathname.match("posts/new") || location.pathname.includes("posts" && "edit")) {
  document.addEventListener("DOMContentLoaded", () => {
    const inputElement = document.getElementById("post_name");
    inputElement.addEventListener("keyup", () => {
      const keywords = document.getElementById("post_name").value.split(",");
      const keyword = keywords[keywords.length - 1];
      keywords.pop()
      const XHR = new XMLHttpRequest();
      XHR.open("GET", `/posts/search/?keyword=${keyword}`, true);
      XHR.responseType = "json";
      XHR.send();
      XHR.onload = () => {
        const searchResult = document.getElementById("search-result");
        searchResult.innerHTML = "";
        if (XHR.response) {
          const tagName = XHR.response.keyword;
          tagName.forEach((tag) => {
            const childElement = document.createElement("div");
            childElement.setAttribute("class", "child");
            childElement.setAttribute("id", tag.id);
            childElement.innerHTML = tag.name;
            searchResult.appendChild(childElement);
            const clickElement = document.getElementById(tag.id);
            clickElement.addEventListener("mouseover", () => {
              clickElement.setAttribute("class", "bg-secondary");
            });
            clickElement.addEventListener("mouseout", () => {
              clickElement.removeAttribute("class", "bg-secondary");
            });
            clickElement.addEventListener("click", () => {
              let newKeyword = "";
              keywords.forEach((restKeyword) => {
                newKeyword += restKeyword + ","
              });
              newKeyword += clickElement.textContent;
              document.getElementById("post_name").value = newKeyword;
              clickElement.remove();
            });
          });
        };
      };
    });
  });
};