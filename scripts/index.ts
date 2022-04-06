//import $ from "jquery";

//const window_wrapper: HTMLElement = document.querySelector(".window")!;
//
//function onDrag(e: MouseEvent) {
//	var get_style: CSSStyleDeclaration = window.getComputedStyle(window_wrapper);
//
//	var left: number = parseInt(get_style.left);
//	var top: number = parseInt(get_style.top);
//
//	window_wrapper.style.left = `${left + e.movementX}px`;
//	window_wrapper.style.top = `${top + e.movementY}px`;
//
//	e.preventDefault();
//
//	console.log(e.movementX, e.movementY);
//}
//
//window_wrapper.addEventListener("mousedown", () => {
//	window_wrapper.classList.add("active");
//	window_wrapper.addEventListener("mousemove", onDrag);
//});
//
//document.addEventListener("mouseup", () => {
//	window_wrapper.classList.remove("active");
//	window_wrapper.removeEventListener("mousemove", onDrag);
//});

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

async function init() {
	const { instance } = await WebAssembly.instantiateStreaming(
		fetch("wasm/out/add.wasm")
	);

	const add = instance.exports.add as CallableFunction;

	console.log(add(4, 1));
}

init();
