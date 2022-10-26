//import * as wasm from "./wasm.js"

//await wasm.init();

//console.log(wasm.add(1, 2));
//console.log(wasm.sub(2, 1));

type Position = {
	x: number,
	y: number,
};

const dragElement = async (elem: HTMLElement) => {
	console.log(elem);
	type PositionUpdate = {
		oldPosition: Position,
		newPosition: Position,
	};
	let position: PositionUpdate = {
		oldPosition: { x: 0, y: 0 },
		newPosition: { x: 0, y: 0 },
	};
	
	elem.onmousedown = function (e: MouseEvent) {
		console.log("mouse down");
		e = e || window.event as MouseEvent;
		
		//e.preventDefault();
		//e.stopPropagation();
		
		position.oldPosition = {
			x: e.clientX,
			y: e.clientY
		};
		
		console.log(position.oldPosition);
		
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
			
			position.newPosition = {
				x: position.oldPosition.x - e.clientX,
				y: position.oldPosition.y - e.clientY
			};
			position.oldPosition = {
				x: e.clientX,
				y: e.clientY
			};
			
			console.log(position);
			console.log(`top: ${elem.offsetTop - position.newPosition.y}, left: ${elem.offsetLeft - position.newPosition.x}`);
			
			elem.style.top = `${elem.offsetTop - position.newPosition.y}px`;
			elem.style.left = `${elem.offsetLeft - position.newPosition.x}px`;
		};
	};
	
	elem = elem.closest(".window");
};

dragElement(document.querySelector("#quit-popup > .titlebar > .titlebar-title")!);
dragElement(document.querySelector("#terminal > .titlebar > .titlebar-title")!);