function createOption(value, text) {
    return createElement('option', {value, text});
}

/*
    createSelect([
        {'SHORTER', 'shorter.'},
        {'CLEARER', 'clearer.'},
        {'FRIENDLIER', 'friendlier.'},
        {'PROFESSIONAL', ' more professional.'}
    ]);
*/
function createSelect(array) {
    const sel = createElement('select', {addEventListener: });
    for (const element of array1) {
        sel.add(createElement('option', {value, text}), null);
    }

    sel.addEventListener('change',function(value){
        console.log('rephrasing...', sel.value, sel.options[sel.selectedIndex].text);
        rewrite(sel.value, editorConfig.aissist.url);
    });
}


function rewrite(modeKey, baseClass, config) {

    const isCKEditor = config.editorType === 'CKEDITOR';
    const editor = isCKEditor
        ? document.getElementById(config.editorId)
            .getElementsByTagName('iframe')[0]
            .contentWindow.document.getElementsByTagName('body')[0]
        : document.getElementById(config.editorId)
    ;

    fetch(config.url, {
        method: 'POST',
        headers: {
            Accept: 'application/json',
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({ type: modeKey, textToRewrite: isCKEditor ? editor.innerText : editor.value })
    })
        .then(response => response.json())
        .then(json => {
            if(isCKEditor) {
                editor.innerText = json.reformulatedText;
            } else {
                editor.value = json.reformulatedText;
            }
            getByClass(config,`${baseClass}-btn`).classList.remove('waiting');
        })
    ;
}

function createElement(tag,options){
    return Object.assign(document.createElement(tag),options);
}

function getByClass(config, className){
    return document
        .getElementById(config.rootId)
        .getElementsByClassName(className)[0]
        ;
}

function createDropdownItem(config, {baseClass, key, value}) {
    return createElement('div', {
        className: 'dropdown-item',
        innerHTML: value,
        onclick: () => {
            toggleDropdown(getByClass(config, `${baseClass}-dropdown`));
            getByClass(config,`${baseClass}-btn`).classList.add('waiting');
            rewrite(key, baseClass, config);
        }
    });
}

function toggleDropdown(dropdownElement) {
    if(dropdownElement.classList.contains('no-display')) {
        dropdownElement.classList.remove('no-display');
    } else {
        dropdownElement.classList.add('no-display');
    }
}

function createDropdown(config, baseClass, list) {
    const dropdown = createElement('div', { className: `${baseClass}-dropdown no-display` });
    for(let i=0; i < list.length; i++) {
        dropdown.appendChild(createDropdownItem(config, {
            baseClass,
            key: list[i].key,
            value: list[i].value
        }));
    }
    return dropdown;
}

function createDropdownButton(config, {baseClass, innerText}) {
    const dropdownButton = createElement('div', { className: `${baseClass}-dropdown-btn` });

    // The dropdown
    const dropdown = createDropdown(config, baseClass, [
        { key: 'SHORTER', value: 'Make it shorter'},
        { key: 'CLEARER', value: 'Make it clearer'},
        { key: 'FRIENDLIER', value: 'Make it friendly'},
        { key: 'PROFESSIONAL', value: 'Sound professional'}
    ]);

    // The button
    const button = createElement('div', {
        className: `${baseClass}-btn`,
        onclick: () => getByClass(config,`${baseClass}-btn`).classList.contains('waiting')
            ? undefined
            : toggleDropdown(dropdown)
    });
    const icon = createElement('div', { className: `${baseClass}-btn-icon` });
    const label = createElement('div', { className: `${baseClass}-btn-label`, innerText});
    const absolute = createElement('div', { className: `${baseClass}-btn-absolute` });
    const spinner = createElement('div', { className: `${baseClass}-btn-spinner` });
    const arrowhead = createElement('div', { className: `${baseClass}-btn-arrowhead` });

    absolute.appendChild(spinner);
    label.appendChild(absolute);

    button.appendChild(icon);
    button.appendChild(label);
    button.appendChild(arrowhead);

    dropdownButton.appendChild(button);
    dropdownButton.appendChild(dropdown);

    return dropdownButton;
}

/**
 * Append the AI assist button
 @param config Object including {url, rootId, pathToAssets, editorType}
 */
function appendAissistButton(config){
    const baseCss = `#${config.rootId} #aissist-plugin`;
    const button = `${baseCss} .aissist-dropdown-btn .aissist-btn`;
    const dropdown = `${baseCss} .aissist-dropdown`;

    console.debug(`Init AI assist in #${config.rootId}... \tconfig =>`, config);

    const exportableCss = `
        #${config.rootId} {
            display: flex;
            align-items: center;
        }
        ${baseCss} {
            margin-left: 10px;
        }
    `;

    const styleTag = createElement('style', {textContent: `${exportableCss}
    ${baseCss} {
        border: 0 dashed pink;
        font-weight: normal;
        display: flex;
    }
    
    ${button} {
        display: flex;
        border-radius: 4px;
        color: #1C2536;
        align-items: center;
        border: 1px solid rgba(14, 19, 27, 0.08);
        background: linear-gradient(90deg, #ADFFC2 0%, #ADF0FF 60%, #A2E0F6 100%);
        padding: 3px 0;
    }
    
    ${button}.waiting {
        background: linear-gradient(90deg, #E9EBEC 0%, #D9DCE1 60%, #BEC3C6 100%);
    }
    
    ${button}:hover {
        border: 1px solid rgba(14, 19, 27, 1);
        color: #0E131B;
    }
    
    ${button} .aissist-btn-icon {
        border: 0 dashed orange;
        background: url(${config.pathToAssets}/pen.png);
        background-repeat: no-repeat;
        height: 18px;
        width: 18px;
        margin: 0 6px;
    }
    
    ${button}.waiting .aissist-btn-icon,
    ${button}.waiting .aissist-btn-arrowhead {
        opacity: 25%;
    }
    
    ${button}.waiting .aissist-btn-label {
        color: #AAA;
        position: relative;
    }
    ${button}.waiting .aissist-btn-absolute {
        position: absolute;
        top: 50%;
        left: 50%;
        transform: translate(-50%, -50%);
    }
    ${button}:not(.waiting) .aissist-btn-spinner {
        display: none;
    }
    ${button}.waiting .aissist-btn-spinner {
        width: 20px;
        aspect-ratio: 1;
        border-radius: 50%;
        border: 4px solid rgba(0, 0, 0, 0.3);
        border-right-color: rgba(0, 0, 0, 0.6);
        animation: spinner-speed 1s infinite ease-in-out;
    }
    @keyframes spinner-speed {
        to{transform: rotate(2turn)}
    }
    
    ${button} .aissist-btn-arrowhead {
        border: 0 dashed FloralWhite;
        border-left: 0 solid rgba(0, 0, 0, 0.23);
        background: url(${config.pathToAssets}/arrowhead.png);
        background-repeat: no-repeat;
        width: 7px;
        height: 5px;
        margin: 0 12px;
    }
    
    ${dropdown} {
        border: 1px solid #D3D7D9;
        box-shadow: 0px 2px 6px 0px #0000004D;
        background-color: white;
        margin: 2px;
        padding: 4px;
        border-radius: 4px;
        position: absolute;
        z-index: 10;
    }
    ${dropdown}.no-display {
        display: none;
    }
    
    ${dropdown} .dropdown-item {
        border: 0px dashed cyan;
        margin: 0;
        padding: 8px;
        border-radius: 4px;
    }
    ${dropdown} .dropdown-item:hover {
        background-color: #EBF2FF;
    }
`});

    const aiAssistBtn = createDropdownButton(config, {
        baseClass: 'aissist',
        innerText: 'AI Assist'
    })

    const rootContainer = createElement('div', {id: 'aissist-plugin'});
    rootContainer.appendChild(styleTag);
    rootContainer.appendChild(aiAssistBtn);
    document.getElementById(config.rootId).appendChild(rootContainer);
}
