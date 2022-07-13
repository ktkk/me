const wasm_source: string = "out.wasm";

export let add: CallableFunction;
export let sub: CallableFunction;

export async function init() {
	const { instance } = await WebAssembly.instantiateStreaming(
		fetch(`wasm/out/${wasm_source}`)
	);

	add = instance.exports.add as CallableFunction;
	sub = instance.exports.sub as CallableFunction;
}
