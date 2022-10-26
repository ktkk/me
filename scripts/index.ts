//import * as wasm from "./wasm.js"

//await wasm.init();

//console.log(wasm.add(1, 2));
//console.log(wasm.sub(2, 1));

const dragElement = async (elem: HTMLElement) => {
	console.log(elem);
	let position = {
		pos1: number = 0,
		pos2: number = 0,
		pos3: number = 0,
		pos4: number = 0,
	};
	
	elem.onmousedown = function (e: MouseEvent) {
		console.log("mouse down");
		e = e || window.event as MouseEvent;
		
		//e.preventDefault();
		//e.stopPropagation();
		
		position.pos3 = e.clientX;
		position.pos4 = e.clientY;
		
		console.log(`pos3: ${position.pos3}, pos4: ${position.pos4}`);
		
		document.onmouseup = function () {
			console.log("mouse up");
			
			document.onmouseup = null;
			document.onmousemove = null;
		};
		document.onmousemove = function (e: MouseEvent) {
			console.log("mouse move");
			e = e || window.event as MouseEvent;
			
			//e.preventDefault();
			//e.stopPropagation();
			
			position.pos1 = position.pos3 - e.clientX;
			position.pos2 = position.pos4 - e.clientY;
			
			position.pos3 = e.clientX;
			position.pos4 = e.clientY;
			
			console.log(`pos1: ${position.pos1}, pos2: ${position.pos2}, pos3: ${position.pos3}, pos4: ${position.pos4}`);
			console.log(`top: ${elem.offsetTop - position.pos2}, left: ${elem.offsetLeft - position.pos1}`);
			
			elem.style.top = `${elem.offsetTop - position.pos2}px`;
			elem.style.left = `${elem.offsetLeft - position.pos1}px`;
		};
	};
	
	elem = elem.closest(".window");
}

dragElement(document.querySelector("#quit-popup > .titlebar > .titlebar-title")!);
dragElement(document.querySelector("#terminal > .titlebar > .titlebar-title")!);