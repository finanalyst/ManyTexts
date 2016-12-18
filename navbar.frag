    <!-- Navigation bar code -->
    <div class="w3-container w3-top ">
        <ul class="w3-navbar w3-center">
            <li class="w3-hide-medium w3-hide-large w3-opennav w3-left w3-dropdown-hover"><a href="#" class="w3-hover-teal"><img src="extras.png"/></a>
                <div class="w3-dropdown-content">
                    <a href="library.html"><img src="books.svg"></a>
                    <button onclick="btnEffect('en','main-en-a')" id="main-en-a" class="w3-btn w3-round-large w3-large w3-blue w3-hover-khaki">English &#x2611;</button>
                    <button onclick="btnEffect('zh-tr','main-zh-tr-a')" id="main-zh-tr-a" class="w3-btn w3-round-large w3-large w3-blue w3-hover-khaki">简体 &#x2611;</button>
                    <button onclick="btnEffect('zh-sm','main-zh-sm-a')" id="main-zh-sm-a" class="w3-btn w3-round-large w3-large w3-blue w3-hover-khaki">繁體 &#x2611;</button>
                   <a href="#" class="w3-hover-teal"><img src="colors.png" onclick="document.getElementById('manytxt-modal').style.display='block'"/></a>
                </div>
            </li>
            <li class="w3-left w3-hide-small"><a href="library.html" class="w3-hover-teal"><img src="books.svg"/></a></li>
            <li class="w3-navitem"><img src="manytextslogo.png" class="w3-round-large"/></li>
            <li class="w3-right w3-hide-small w3-dropdown-hover" ><a href="#" class="w3-hover-teal"><img src="colors.png" onclick="document.getElementById('manytxt-modal').style.display='block'"/></a>
            </li>
            <li class="w3-right w3-hide-small w3-dropdown-hover" ><a href="#" class="w3-hover-teal"><img src="language.svg"/></a>
                <div class="w3-dropdown-content">
                    <button onclick="btnEffect('en','main-en-b')" id="main-en-b" class="w3-btn w3-round-large w3-large w3-blue w3-hover-khaki">English &#x2611;</button>
                    <button onclick="btnEffect('zh-tr','main-zh-tr-b')" id="main-zh-tr-b" class="w3-btn w3-round-large w3-large w3-blue w3-hover-khaki">简体 &#x2611;</button>
                    <button onclick="btnEffect('zh-sm','main-zh-sm-b')" id="main-zh-sm-b" class="w3-btn w3-round-large w3-large w3-blue w3-hover-khaki">繁體 &#x2611;</button>
                </div>
            </li>
        </ul>
    </div>
    <div class="w3-modal" id="manytxt-modal">
        <div class="w3-modal-content">
            <div class="w3-container manytxt-top">
                <span onclick="document.getElementById('manytxt-modal').style.display='none'" class="w3-closebtn">&times;</span>
                <button onclick="textSizeEffect(0)" class="w3-btn w3-round-large w3-medium w3-blue w3-hover-khaki ">English 简体 繁體</button>
                <button onclick="textSizeEffect(1)" class="w3-btn w3-round-large w3-xlarge w3-blue w3-hover-khaki">English 简体 繁體</button>
                <button onclick="textSizeEffect(2)" class="w3-btn w3-round-large w3-xxlarge w3-blue w3-hover-khaki">English 简体 繁體</button>
                <button onclick="textCombination(8,4)" class="w3-btn w3-round-large w3-blue w3-hover-text-black w3-hover-sand">English 简体 繁體</button>
                <button onclick="textCombination(12,7)" class="w3-btn w3-round-large w3-blue w3-hover-text-white w3-hover-black">English 简体 繁體</button>
                <button onclick="textCombination(10,7)" class="w3-btn w3-round-large w3-blue w3-hover-text-aqua w3-hover-black">English 简体 繁體</button>
                <button onclick="textCombination(9,5)" class="w3-btn w3-round-large w3-blue w3-hover-text-brown w3-hover-light-grey">English 简体 繁體</button>
                <button onclick="textCombination(11,6)" class="w3-btn w3-round-large w3-blue w3-hover-text-green w3-hover-indigo">English 简体 繁體</button>
                <p style="text-align:center;">English 简体 繁體</p>
            </div>
        </div>
    </div>
<!-- End of navigation bar -->