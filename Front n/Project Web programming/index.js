function clickUsername() {
    document.getElementById("myDropdown").classList.toggle("show");
}

window.onclick = function (ev) {
    if (!ev.target.matches('.dropbtn')){
        var dropdowns = document.getElementsByClassName("dropdown-menu")
        var i;
        for (i=0 ; i<dropdowns.length ; i++){
            var openDropdown = dropdowns[i];
            if (openDropdown.classList.contains('show')){
                openDropdown.classList.remove('show')
            }
        }
    }
}
