export class Wasm {
	static #wasmSource: string = "out.wasm";

	add: CallableFunction;
	sub: CallableFunction;

	constructor() {
		WebAssembly.instantiateStreaming(fetch(`wasm/out/${Wasm.#wasmSource}`)).then((obj) => {
			this.add = obj.instance.exports.add as CallableFunction;
			this.sub = obj.instance.exports.sub as CallableFunction;
		});
	}
}