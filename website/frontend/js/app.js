const API_URL = "/api/usuario";

document.addEventListener("DOMContentLoaded", () => {
    cargarUsuarios();
});

// ----------------------------------------------------
// CARGAR USUARIOS EN LA TABLA
// ----------------------------------------------------
async function cargarUsuarios() {
    const res = await fetch(API_URL);
    const usuarios = await res.json();

    const tbody = document.getElementById("tabla-usuarios");
    tbody.innerHTML = "";

    usuarios.forEach(u => {
        tbody.innerHTML += `
            <tr>
                <td>${u.UsuarioID}</td>
                <td>${u.Cedula}</td>
                <td>${u.Nombre}</td>
                <td>${u.Apellido}</td>
                <td>${u.Telefono}</td>
                <td>${u.Correo}</td>
                <td>
                    <button class="btn btn-warning btn-sm" onclick="cargarEdicion(${u.UsuarioID})">Editar</button>
                    <button class="btn btn-danger btn-sm" onclick="eliminarUsuario(${u.UsuarioID})">Eliminar</button>
                </td>
            </tr>
        `;
    });
}

// ----------------------------------------------------
// CREAR USUARIO
// ----------------------------------------------------
async function crearUsuario() {
    const data = obtenerDatosFormulario();

    const res = await fetch(API_URL, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(data)
    });

    if (res.ok) {
        cerrarModal();
        cargarUsuarios();
    }
}

// ----------------------------------------------------
// CARGAR DATOS PARA EDITAR
// ----------------------------------------------------
async function cargarEdicion(id) {
    // Obtener usuario por ID desde el backend
    const res = await fetch(API_URL);
    const usuarios = await res.json();
    const u = usuarios.find(x => x.UsuarioID === id);

    document.getElementById("usuarioID").value = u.UsuarioID;
    document.getElementById("cedula").value = u.Cedula;
    document.getElementById("nombre").value = u.Nombre;
    document.getElementById("apellido").value = u.Apellido;
    document.getElementById("telefono").value = u.Telefono;
    document.getElementById("correo").value = u.Correo;

    abrirModal();
}

// ----------------------------------------------------
// ACTUALIZAR USUARIO
// ----------------------------------------------------
async function actualizarUsuario() {
    const id = document.getElementById("usuarioID").value;
    const data = obtenerDatosFormulario();

    const res = await fetch(`${API_URL}/${id}`, {
        method: "PUT",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(data)
    });

    if (res.ok) {
        cerrarModal();
        cargarUsuarios();
    }
}

// ----------------------------------------------------
// ELIMINAR USUARIO
// ----------------------------------------------------
async function eliminarUsuario(id) {
    if (!confirm("¿Confirmar eliminación?")) return;

    const res = await fetch(`${API_URL}/${id}`, {
        method: "DELETE"
    });

    if (res.ok) {
        cargarUsuarios();
    }
}

// ----------------------------------------------------
// UTILIDADES
// ----------------------------------------------------
function obtenerDatosFormulario() {
    return {
        Cedula: document.getElementById("cedula").value,
        Nombre: document.getElementById("nombre").value,
        Apellido: document.getElementById("apellido").value,
        Telefono: document.getElementById("telefono").value,
        Correo: document.getElementById("correo").value
    };
}

// ----------------------------------------------------
// CONTROLES DEL MODAL
// ----------------------------------------------------
function abrirModal() {
    const modal = new bootstrap.Modal(document.getElementById("modalUsuario"));
    modal.show();

    document.getElementById("btn-guardar").onclick = () => {
        const id = document.getElementById("usuarioID").value;
        if (id === "") crearUsuario();
        else actualizarUsuario();
    };
}

function cerrarModal() {
    const modal = bootstrap.Modal.getInstance(document.getElementById("modalUsuario"));
    modal.hide();
}

function nuevoUsuario() {
    document.getElementById("usuarioID").value = "";
    document.getElementById("cedula").value = "";
    document.getElementById("nombre").value = "";
    document.getElementById("apellido").value = "";
    document.getElementById("telefono").value = "";
    document.getElementById("correo").value = "";

    abrirModal();
}
