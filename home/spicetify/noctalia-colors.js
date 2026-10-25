(function noctaliaColors() {
    const link = document.querySelector("link.userCSS[href='colors.css']");
    if (!link) {
        setTimeout(noctaliaColors, 300);
        return;
    }

    const style = document.createElement("style");
    style.id = "noctalia-colors";
    link.after(style);

    let current = "";
    async function refresh() {
        if (document.hidden) return;
        try {
            const response = await fetch("colors.css", { cache: "no-store" });
            if (!response.ok) return;
            const css = await response.text();
            if (css === current || !css.trimEnd().endsWith("}")) return;
            style.textContent = css;
            current = css;
        } catch {
        }
    }

    refresh();
    setInterval(refresh, 2000);
    document.addEventListener("visibilitychange", refresh);
})();
