import * as wasm from "./wasm.js"

await wasm.init();

console.log(wasm.add(1, 2));
console.log(wasm.sub(2, 1));

drag_element(document.querySelector(".window")!);

function drag_element(elem: HTMLElement) {
	var pos1: number = 0, pos2: number = 0, pos3: number = 0, pos4: number = 0;

	elem.onmousedown = drag_mouse_down;

	function drag_mouse_down(e: MouseEvent) {
		e = e || window.event as MouseEvent;

		e.preventDefault();

		pos3 = e.clientX;
		pos4 = e.clientY;

		document.onmouseup = close_drag_element;
		document.onmousemove = element_drag;
	}

	function element_drag(e: MouseEvent) {
		e = e || window.event as MouseEvent;

		e.preventDefault();

		pos1 = pos3 - e.clientX;
		pos2 = pos4 - e.clientY;

		pos3 = e.clientX;
		pos4 = e.clientY;

		elem.style.top = `${elem.offsetTop - pos2}px`;
		elem.style.left = `${elem.offsetLeft - pos1}px`;
	}

	function close_drag_element() {
		document.onmouseup = null;
		document.onmousemove = null;
	}
}
