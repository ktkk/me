//import * as wasm from "./wasm.js"

//await wasm.init();

//console.log(wasm.add(1, 2));
//console.log(wasm.sub(2, 1));

drag_element(document.querySelector("#quit-popup > .titlebar > .titlebar-title")!);
drag_element(document.querySelector("#terminal > .titlebar > .titlebar-title")!);

async function drag_element(elem: HTMLElement) {
	console.log(elem);
	var pos1: number = 0, pos2: number = 0, pos3: number = 0, pos4: number = 0;

	elem.onmousedown = drag_mouse_down;

	elem = elem.closest(".window");

	function drag_mouse_down(e: MouseEvent) {
		console.log("mouse down");
		e = e || window.event as MouseEvent;

		//e.preventDefault();
		//e.stopPropagation();

		pos3 = e.clientX;
		pos4 = e.clientY;

		console.log(`pos3: ${pos3}, pos4: ${pos4}`);

		document.onmouseup = close_drag_element;
		document.onmousemove = element_drag;
	}

	function element_drag(e: MouseEvent) {
		console.log("mouse move");
		e = e || window.event as MouseEvent;

		//e.preventDefault();
		//e.stopPropagation();

		pos1 = pos3 - e.clientX;
		pos2 = pos4 - e.clientY;

		pos3 = e.clientX;
		pos4 = e.clientY;

		console.log(`pos1: ${pos1}, pos2: ${pos2}, pos3: ${pos3}, pos4: ${pos4}`);
		console.log(`top: ${elem.offsetTop - pos2}, left: ${elem.offsetLeft - pos1}`);

		elem.style.top = `${elem.offsetTop - pos2}px`;
		elem.style.left = `${elem.offsetLeft - pos1}px`;
	}

	function close_drag_element() {
		console.log("mouse up");

		document.onmouseup = null;
		document.onmousemove = null;
	}
}
