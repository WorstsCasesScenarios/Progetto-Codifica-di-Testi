document.addEventListener('DOMContentLoaded', function () {
    //zoom click + drag + scroll

    let zoomedImg = null;
    let scale     = 1.5;
    let tx = 0, ty = 0;
    let dragStartX = 0, dragStartY = 0;
    let dragging   = false;
    let dragMoved  = false;

    function applyTransform() {
        if (!zoomedImg) return;
        zoomedImg.style.transform =
            `translate(calc(-50% + ${tx}px), calc(-50% + ${ty}px)) scale(${scale})`;
    }

    function openZoom(img) {
        if (zoomedImg && zoomedImg !== img) closeZoom();
        zoomedImg = img;
        scale = 1.5;
        tx = 0; ty = 0;
        dragMoved = false;
        img.classList.add('zoomed');
        applyTransform();
    }

    function closeZoom() {
        if (!zoomedImg) return;
        zoomedImg.classList.remove('zoomed');
        zoomedImg.style.transform = '';
        zoomedImg = null;
        scale = 1.5; tx = 0; ty = 0;
        dragMoved = false;
    }


    document.addEventListener('mousedown', e => {
        if (!zoomedImg) return;
        //solo click col tasto sinistro
        if (e.button !== 0) return;
        dragging   = true;
        dragMoved  = false;
        dragStartX = e.clientX - tx;
        dragStartY = e.clientY - ty;
        e.preventDefault();
    });

    document.addEventListener('mousemove', e => {
        if (!dragging || !zoomedImg) return;
        const newTx = e.clientX - dragStartX;
        const newTy = e.clientY - dragStartY;
        if (Math.abs(newTx - tx) > 4 || Math.abs(newTy - ty) > 4) dragMoved = true;
        tx = newTx; ty = newTy;
        applyTransform();
    });

    document.addEventListener('mouseup', () => {
        dragging = false;
    });

    //click sulle immagini
    document.querySelectorAll('.facsimile-img').forEach(img => {
        img.addEventListener('click', e => {
            if (dragMoved) {
                dragMoved = false;
                e.stopPropagation();
                return;
            }
            if (zoomedImg === img) {
                closeZoom();
            } else {
                openZoom(img);
            }
        });
    });

    // tasto esc
    document.addEventListener('keydown', e => {
        if (e.key === 'Escape') closeZoom();
    });

    // Scroll wheel → zoom in/out
    let wheelPending = false;
    document.addEventListener('wheel', e => {
        if (!zoomedImg) return;
        e.preventDefault();
        if (wheelPending) return; // Fix #5: throttle con rAF
        wheelPending = true;
        requestAnimationFrame(() => {
            scale = Math.min(Math.max(scale + (e.deltaY < 0 ? 0.2 : -0.2), 0.3), 8);
            applyTransform();
            wheelPending = false;
        });
    }, { passive: false });



    //Highlight Toolbar

    function queryByAna(ana) {
        return Array.from(document.querySelectorAll('[data-ana]')).filter(el =>
            el.getAttribute('data-ana').split(/\s+/).includes(ana)
        );
    }

    document.querySelectorAll('.highlight-btn').forEach(btn => {
        btn.addEventListener('click', () => {
            const tipo     = btn.getAttribute('data-tipo');
            const isAttivo = btn.classList.toggle('attivo');
            const sel      = btn.parentElement.querySelector('.highlight-select');
            document.querySelectorAll('.' + tipo).forEach(el =>
                el.classList.toggle('highlight-on', isAttivo)
            );
            if (!isAttivo && sel) sel.value = '';
        });
    });

    document.querySelectorAll('.highlight-select').forEach(sel => {
        sel.addEventListener('change', () => {
            const tipo = sel.getAttribute('data-tipo');
            const ana  = sel.value;
            const btn  = sel.parentElement.querySelector('.highlight-btn');
            document.querySelectorAll('.' + tipo).forEach(el =>
                el.classList.remove('highlight-on')
            );
            if (ana === '') {
                btn?.classList.remove('attivo');
            } else {
                btn?.classList.add('attivo');
                queryByAna(ana).forEach(el => el.classList.add('highlight-on'));
            }
        });
    });

});
