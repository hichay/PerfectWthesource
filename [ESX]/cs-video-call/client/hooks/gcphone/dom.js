window.CS_VIDEO_CALL.hookInterface = () => {
    jQuery('.phone_screen:first').prepend(`
        <canvas id="cs-video-clone"></canvas>
        <video id="cs-virtual-video"></video>

        <div id="cs-self-video-container">
            <canvas id="cs-self-video"></canvas>

            <div class="buttons-container">
                <button class="btn" data-action="cs-video-call-swap-filter"><svg enable-background="new 0 0 971.986 971.986" version="1.1" viewBox="0 0 971.99 971.99" xml:space="preserve" xmlns="http://www.w3.org/2000/svg"><path d="m370.22 459.3c10.2 11.1 15.8 25.6 15.8 40.6v442c0 26.601 32.1 40.101 51.1 21.4l123.3-141.3c16.5-19.8 25.6-29.601 25.6-49.2v-272.8c0-15 5.7-29.5 15.8-40.601l353.8-383.9c26.5-28.8 6.101-75.5-33.1-75.5h-873c-39.2 0-59.7 46.6-33.1 75.5l353.8 383.8z"/></svg></button>
                <button class="btn" data-action="cs-video-call-swap-camera"><svg enable-background="new 0 0 512 512" version="1.1" viewBox="0 0 512 512" xml:space="preserve" xmlns="http://www.w3.org/2000/svg"><path d="m493.82 70.629c-11.001-1.003-20.73 7.102-21.733 18.102l-2.65 29.069c-44.959-70.606-123-117.8-213.43-117.8-97.281 0-183.01 55.522-225.57 138.85-5.024 9.837-1.122 21.884 8.715 26.908 9.839 5.024 21.884 1.123 26.908-8.715 36.017-70.524 108.34-117.05 189.95-117.05 74.377 0 141.5 38.731 179.95 99.408l-28.517-20.367c-8.989-6.419-21.48-4.337-27.899 4.651-6.419 8.989-4.337 21.479 4.651 27.899l86.475 61.761c12.674 9.035 30.155 0.764 31.541-14.459l9.711-106.53c1.004-11.001-7.1-20.731-18.1-21.734z"/><path d="m472.86 346.24c-9.838-5.023-21.884-1.122-26.908 8.715-36.017 70.524-108.34 117.05-189.95 117.05-74.377 0-141.5-38.731-179.95-99.408l28.517 20.367c8.989 6.419 21.479 4.337 27.899-4.651 6.419-8.989 4.337-21.479-4.651-27.899l-86.475-61.761c-12.519-8.944-30.141-0.921-31.541 14.459l-9.711 106.53c-1.003 11 7.102 20.73 18.101 21.733 11.014 1.001 20.731-7.112 21.733-18.102l2.65-29.069c44.958 70.607 123 117.8 213.43 117.8 97.281 0 183.01-55.522 225.57-138.85 5.024-9.837 1.122-21.884-8.715-26.908z"/></svg></button>
            </div>
        </div>

        <video id="cs-remote-video"></video>
    `)

    jQuery('.phone_screen:first .phone_app:first .actionbox:first').prepend('<div data-action="cs-video-call-swap-transmission" style="display: none;"><svg enable-background="new 0 0 488.3 488.3" version="1.1" viewBox="0 0 488.3 488.3" xml:space="preserve" xmlns="http://www.w3.org/2000/svg"><path d="m488.3 142.5v203.1c0 15.7-17 25.5-30.6 17.7l-84.6-48.8v13.9c0 41.8-33.9 75.7-75.7 75.7h-221.7c-41.8 0-75.7-33.9-75.7-75.7v-168.5c0-41.8 33.9-75.7 75.7-75.7h221.8c41.8 0 75.7 33.9 75.7 75.7v13.9l84.6-48.8c13.5-8 30.5 1.9 30.5 17.5z"/></svg></div>')

    return jQuery('.phone_screen:first')
}

jQuery('body').on('DOMSubtreeModified', event => {
    if (jQuery('.phone_screen:first .phone_app:first .actionbox:first').length > 0)
        window.CS_VIDEO_CALL.hookDocument()
    else
        window.CS_VIDEO_CALL.unhookDocument()
})
