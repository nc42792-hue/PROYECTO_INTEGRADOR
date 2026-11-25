// =========================================================================
// BLOQUE 1: INTERCEPTOR DE DATOS, PERMISOS POR ROL Y ESQUEMAS CRUD
// =========================================================================
(function () {
  let tablaActiva = "pedidos";
  let registrosOriginales = [];
  let esEdicion = false;
  let idEditando = null;

  function obtenerRol() {
    const txt = (document.body.innerText || "").toUpperCase();
    if (txt.includes("ADMINISTRADOR")) return "Administrador";
    if (txt.includes("VENTAS")) return "Ventas";
    if (txt.includes("CONTADOR") || txt.includes("CONTABILIDAD")) return "Contador";
    return "Administrador";
  }

  const ESQUEMAS = {
    usuarios: {
      pk: "id_usuario",
      campos: [
        { name: "usuario", label: "Usuario (Login)", type: "text", required: true },
        { name: "nombre_completo", label: "Nombre Completo", type: "text", required: true },
        { name: "rol", label: "Rol del Sistema", type: "select", options: ["Administrador", "Ventas", "Contador"], required: true },
        { name: "contrasenia", label: "Contraseña (vacío = mantener)", type: "password", required: false }
      ]
    },
    clientes: {
      pk: "id_cliente",
      campos: [
        { name: "id_cliente", label: "Cédula / NIT", type: "text", required: true },
        { name: "nombre_completo", label: "Nombre Completo / Razón Social", type: "text", required: true },
        { name: "telefono", label: "Teléfono", type: "text", required: true },
        { name: "direccion", label: "Dirección", type: "text", required: false },
        { name: "tipo_cliente", label: "Tipo de Cliente", type: "select", options: ["Particular", "Empresa"], required: true }
      ]
    },
    productos: {
      pk: "id_producto",
      campos: [
        { name: "nombre_producto", label: "Nombre del Producto", type: "text", required: true },
        { name: "categoria", label: "Categoría", type: "text", required: true },
        { name: "precio_venta_base", label: "Precio Venta Base ($ COP)", type: "number", required: true },
        { name: "costo_estimado", label: "Costo Estimado ($ COP)", type: "number", required: true }
      ]
    },
    materiales: {
      pk: "id_material",
      campos: [
        { name: "nombre_material", label: "Nombre del Material", type: "text", required: true },
        { name: "unidad_medida", label: "Unidad de Medida", type: "text", required: true },
        { name: "stock_disponible", label: "Stock Disponible", type: "number", required: true },
        { name: "costo_unitario", label: "Costo Unitario ($ COP)", type: "number", required: true }
      ]
    },
    pedidos: {
      pk: "id_pedido",
      campos: [
        { name: "id_pedido", label: "Código Pedido (ej. PED-1151)", type: "text", required: true },
        { name: "id_cliente", label: "ID Cliente (Cédula / NIT)", type: "text", required: true },
        { name: "tipo_mueble", label: "Producto / Línea de Mueble", type: "select", options: ["Closet Modular", "Cocina Integral", "Puerta Tamborada", "Piso en Madera", "Escalera en Madera", "Mueble de Baño"], required: true },
        { name: "material_principal", label: "Material Principal", type: "select", options: ["Madecor 15mm (Melamina)", "Triplex Okume", "Triplex Otobo", "Triplex Flor Morado", "Madera Cedro", "Madera Flor Morado", "Madera Pino", "Lámina Alto Brillo/Mate"], required: true },
        { name: "artesano_nombre", label: "Artesano Asignado", type: "text", required: false },
        { name: "cantidad_piezas", label: "Cantidad de Piezas", type: "number", required: true },
        { name: "monto_total", label: "Monto Total ($ COP)", type: "number", required: true },
        { name: "dias_fabricacion", label: "Días Fabricación", type: "number", required: true },
        { name: "estado_pedido", label: "Estado del Pedido", type: "select", options: ["En Producción", "En Acabado", "Completado"], required: true }
      ]
    },
    ventas: {
      pk: "id_venta",
      campos: [
        { name: "id_venta", label: "Código Venta (ej. VTA-2065)", type: "text", required: true },
        { name: "id_pedido", label: "Código Pedido Asociado", type: "text", required: true },
        { name: "id_cliente", label: "ID Cliente", type: "text", required: true },
        { name: "metodo_pago", label: "Método de Pago", type: "select", options: ["Transferencia", "Efectivo", "Tarjeta de Crédito", "Tarjeta de Débito"], required: true },
        { name: "subtotal", label: "Subtotal ($ COP)", type: "number", required: true },
        { name: "impuestos", label: "IVA / Impuestos ($ COP)", type: "number", required: true },
        { name: "total_pagado", label: "Total Pagado ($ COP)", type: "number", required: true }
      ]
    }
  };

  function puedeCrear(t) {
    const r = obtenerRol();
    if (r === "Administrador") return true;
    if (r === "Ventas") return ["pedidos", "clientes", "ventas"].includes(t);
    if (r === "Contador") return ["ventas", "materiales", "productos"].includes(t);
    return false;
  }
  function puedeEditar(t) {
    const r = obtenerRol();
    if (r === "Administrador") return true;
    if (r === "Ventas") return ["pedidos", "clientes"].includes(t);
    if (r === "Contador") return ["ventas", "materiales"].includes(t);
    return false;
  }
  function puedeEliminar() { return obtenerRol() === "Administrador"; }
  // =========================================================================
  // BLOQUE 2: REEMPLAZO DE FILTROS ORIGINALES Y DIBUJO DE TABLA CON BOTONES
  // =========================================================================
  function detectarTablaPorTitulo() {
    const h = document.querySelector("h1, h2, .section-title, .view-title");
    const t = (h ? h.textContent : document.body.innerText).toUpperCase();
    if (t.includes("GESTIÓN DE PEDIDOS")) return "pedidos";
    if (t.includes("GESTIÓN DE VENTAS")) return "ventas";
    if (t.includes("GESTIÓN DE PRODUCTOS")) return "productos";
    if (t.includes("GESTIÓN DE MATERIALES")) return "materiales";
    if (t.includes("GESTIÓN DE CLIENTES")) return "clientes";
    if (t.includes("GESTIÓN DE USUARIOS")) return "usuarios";
    return tablaActiva;
  }

  function inyectarFiltrosEnCajaBlanca(tabla) {
    const tablaEl = Array.from(document.querySelectorAll("table")).find(t => t.offsetParent !== null && !t.id.startsWith("ct-ger"));
    if (!tablaEl) return;

    // Buscar la caja blanca de filtros original (la que tiene el select "Todos los Estados" o input date)
    let cajaFiltros = tablaEl.parentElement.previousElementSibling;
    if (!cajaFiltros) return;

    const st = "padding:7px 10px; border:1px solid #cbbab6; border-radius:6px; font-size:0.84rem; background:#fff; color:#2b1d1a;";
    if (tabla === "pedidos") {
      cajaFiltros.innerHTML = `
        <div style="display:flex; flex-wrap:wrap; gap:8px; width:100%; align-items:center;">
          <select id="ct_f_prod" onchange="ctAplicarFiltros()" style="${st}">
            <option value="">Todos los Productos</option>
            <option value="Closet Modular">Closet Modular</option>
            <option value="Cocina Integral">Cocina Integral</option>
            <option value="Puerta Tamborada">Puerta Tamborada</option>
            <option value="Piso en Madera">Piso en Madera</option>
            <option value="Escalera en Madera">Escalera en Madera</option>
            <option value="Mueble de Baño">Mueble de Baño</option>
          </select>
          <select id="ct_f_mat" onchange="ctAplicarFiltros()" style="${st}">
            <option value="">Todos los Materiales</option>
            <option value="Madecor 15mm (Melamina)">Madecor 15mm (Melamina)</option>
            <option value="Triplex Okume">Triplex Okume</option>
            <option value="Triplex Otobo">Triplex Otobo</option>
            <option value="Triplex Flor Morado">Triplex Flor Morado</option>
            <option value="Madera Cedro">Madera Cedro</option>
            <option value="Madera Flor Morado">Madera Flor Morado</option>
            <option value="Madera Pino">Madera Pino</option>
            <option value="Lámina Alto Brillo/Mate">Lámina Alto Brillo/Mate</option>
          </select>
          <select id="ct_f_est" onchange="ctAplicarFiltros()" style="${st}">
            <option value="">Todos los Estados</option>
            <option value="En Producción">En Producción</option>
            <option value="En Acabado">En Acabado</option>
            <option value="Completado">Completado</option>
          </select>
          <input id="ct_f_cli" onkeyup="ctAplicarFiltros()" placeholder="ID Cliente..." style="${st} width:120px;">
          <input id="ct_f_art" onkeyup="ctAplicarFiltros()" placeholder="Nombre Artesano..." style="${st} width:145px;">
          <label style="font-size:0.8rem; color:#444;">F. Pedido: <input type="date" id="ct_f_fped" onchange="ctAplicarFiltros()" style="${st}"></label>
          <label style="font-size:0.8rem; color:#444;">F. Entrega: <input type="date" id="ct_f_fent" onchange="ctAplicarFiltros()" style="${st}"></label>
          <button onclick="ctLimpiarFiltros()" style="padding:7px 14px; background:#6d2e35; color:#fff; border:none; border-radius:6px; cursor:pointer; font-weight:600;">Limpiar</button>
        </div>`;
    } else if (tabla === "ventas") {
      cajaFiltros.innerHTML = `
        <div style="display:flex; flex-wrap:wrap; gap:10px; width:100%; align-items:center;">
          <input id="ct_v_cli" onkeyup="ctAplicarFiltros()" placeholder="ID Cliente..." style="${st} width:150px;">
          <input id="ct_v_ven" onkeyup="ctAplicarFiltros()" placeholder="Nombre Vendedor..." style="${st} width:180px;">
          <label style="font-size:0.8rem; color:#444;">Fecha de Venta: <input type="date" id="ct_v_fec" onchange="ctAplicarFiltros()" style="${st}"></label>
          <button onclick="ctLimpiarFiltros()" style="padding:7px 14px; background:#6d2e35; color:#fff; border:none; border-radius:6px; cursor:pointer; font-weight:600;">Limpiar</button>
        </div>`;
    }
  }

  window.ctLimpiarFiltros = function () {
    document.querySelectorAll("#ct_f_prod,#ct_f_mat,#ct_f_est,#ct_f_cli,#ct_f_art,#ct_f_fped,#ct_f_fent,#ct_v_cli,#ct_v_ven,#ct_v_fec").forEach(e => e.value = "");
    ctAplicarFiltros();
  };

  window.ctAplicarFiltros = function () {
    let lista = [...registrosOriginales];
    if (tablaActiva === "pedidos") {
      const prod = (document.getElementById("ct_f_prod")?.value || "").toLowerCase();
      const mat = (document.getElementById("ct_f_mat")?.value || "").toLowerCase();
      const est = (document.getElementById("ct_f_est")?.value || "").toLowerCase();
      const cli = (document.getElementById("ct_f_cli")?.value || "").toLowerCase();
      const art = (document.getElementById("ct_f_art")?.value || "").toLowerCase();
      const fped = document.getElementById("ct_f_fped")?.value || "";
      const fent = document.getElementById("ct_f_fent")?.value || "";

      lista = lista.filter(r =>
        (!prod || (r.tipo_mueble || "").toLowerCase().includes(prod)) &&
        (!mat || (r.material_principal || "").toLowerCase().includes(mat)) &&
        (!est || (r.estado_pedido || "").toLowerCase() === est) &&
        (!cli || (r.id_cliente || "").toLowerCase().includes(cli)) &&
        (!art || (r.nombre_artesano || r.artesano_nombre || "").toLowerCase().includes(art)) &&
        (!fped || (r.fecha_pedido || "").startsWith(fped)) &&
        (!fent || (r.fecha_entrega_estimada || r.fecha_entrega || "").startsWith(fent))
      );
    } else if (tablaActiva === "ventas") {
      const cli = (document.getElementById("ct_v_cli")?.value || "").toLowerCase();
      const ven = (document.getElementById("ct_v_ven")?.value || "").toLowerCase();
      const fec = document.getElementById("ct_v_fec")?.value || "";

      lista = lista.filter(r =>
        (!cli || (r.id_cliente || "").toLowerCase().includes(cli)) &&
        (!ven || (r.nombre_vendedor || "").toLowerCase().includes(ven)) &&
        (!fec || (r.fecha_venta || "").startsWith(fec))
      );
    }
    renderizarFilasConAcciones(lista);
  };

  function renderizarFilasConAcciones(filas) {
    const tablaEl = Array.from(document.querySelectorAll("table")).find(t => t.offsetParent !== null && !t.id.startsWith("ct-ger"));
    if (!tablaEl) return;
    const thead = tablaEl.querySelector("thead");
    const tbody = tablaEl.querySelector("tbody");
    if (!thead || !tbody) return;

    if (!filas.length) {
      tbody.innerHTML = '<tr><td colspan="15" style="padding:18px; text-align:center; color:#666;">No se encontraron registros con los filtros seleccionados.</td></tr>';
      return;
    }

    const cols = Object.keys(filas[0]);
    const mostrarAcc = puedeEditar(tablaActiva) || puedeEliminar();

    thead.innerHTML = "<tr>" +
      cols.map(c => `<th style="padding:11px 10px; text-align:left; white-space:nowrap;">${c.replace(/_/g, " ").toUpperCase()}</th>`).join("") +
      (mostrarAcc ? '<th style="padding:11px 10px; text-align:center;">ACCIONES</th>' : "") +
      "</tr>";

    const pk = ESQUEMAS[tablaActiva].pk;
    tbody.innerHTML = filas.map(f => {
      const tds = cols.map(c => `<td style="padding:9px 10px; border-bottom:1px solid #e6dedc;">${f[c] !== null && f[c] !== undefined ? f[c] : "-"}</td>`).join("");
      let acc = "";
      if (mostrarAcc) {
        const enc = encodeURIComponent(JSON.stringify(f));
        const bEdit = puedeEditar(tablaActiva)
          ? `<button onclick="ctAbrirModal('${tablaActiva}', '${enc}')" style="background:#6d2e35; color:#fff; border:none; padding:6px 12px; border-radius:6px; cursor:pointer; font-weight:600; margin-right:6px;">Editar</button>`
          : "";
        const bDel = puedeEliminar()
          ? `<button onclick="ctEliminar('${tablaActiva}', '${f[pk]}')" style="background:#d9534f; color:#fff; border:none; padding:6px 12px; border-radius:6px; cursor:pointer; font-weight:600;">Eliminar</button>`
          : "";
        acc = `<td style="padding:9px 10px; border-bottom:1px solid #e6dedc; text-align:center; white-space:nowrap;">${bEdit}${bDel}</td>`;
      }
      return `<tr>${tds}${acc}</tr>`;
    }).join("");
  }
  // =========================================================================
  // BLOQUE 3: MODAL DE EDICIÓN/CREACIÓN, TABLAS GERENCIALES Y TIEMPO REAL
  // =========================================================================
  function crearModalSiNoExiste() {
    if (document.getElementById("ct-modal")) return;
    document.body.insertAdjacentHTML("beforeend", `
      <div id="ct-modal" style="display:none; position:fixed; inset:0; background:rgba(0,0,0,0.65); z-index:999999; align-items:center; justify-content:center;">
        <div style="background:#fff; color:#2b1d1a; width:92%; max-width:500px; border-radius:12px; padding:24px; box-shadow:0 15px 35px rgba(0,0,0,0.35); max-height:88vh; overflow-y:auto;">
          <div style="display:flex; justify-content:space-between; align-items:center; border-bottom:1px solid #e5d8d5; padding-bottom:10px; margin-bottom:14px;">
            <h3 id="ct-modal-titulo" style="margin:0; font-size:1.15rem; color:#5a2328;">Gestionar Registro</h3>
            <button onclick="ctCerrarModal()" style="background:none; border:none; font-size:1.5rem; cursor:pointer; color:#666;">&times;</button>
          </div>
          <form onsubmit="ctGuardar(event)">
            <div id="ct-modal-campos" style="display:flex; flex-direction:column; gap:11px;"></div>
            <div style="display:flex; justify-content:flex-end; gap:10px; margin-top:18px; border-top:1px solid #eee; padding-top:12px;">
              <button type="button" onclick="ctCerrarModal()" style="padding:8px 16px; border:1px solid #ccc; border-radius:6px; background:#f5f5f5; cursor:pointer;">Cancelar</button>
              <button type="submit" style="padding:8px 18px; border:none; border-radius:6px; background:#6d2e35; color:#fff; font-weight:600; cursor:pointer;">Guardar Cambios</button>
            </div>
          </form>
        </div>
      </div>`);
  }

  window.ctRecargarTabla = async function (tabla) {
    tablaActiva = tabla || detectarTablaPorTitulo();
    const res = await fetch("/api/tabla/" + tablaActiva);
    if (!res.ok) return;
    registrosOriginales = await res.json();

    // Conectar botón "+ Nuevo Registro" visible en la esquina superior derecha
    document.querySelectorAll("button").forEach(btn => {
      if (btn.textContent.includes("Nuevo Registro") || btn.textContent.includes("+ Nuevo")) {
        btn.style.display = puedeCrear(tablaActiva) ? "inline-flex" : "none";
        btn.onclick = (e) => {
          e.preventDefault();
          e.stopPropagation();
          ctAbrirModal(tablaActiva, null);
        };
      }
    });

    inyectarFiltrosEnCajaBlanca(tablaActiva);
    renderizarFilasConAcciones(registrosOriginales);
  };

  window.ctAbrirModal = function (tabla, filaEnc) {
    crearModalSiNoExiste();
    tablaActiva = tabla;
    const esq = ESQUEMAS[tabla];
    const fila = filaEnc ? JSON.parse(decodeURIComponent(filaEnc)) : null;
    esEdicion = !!fila;
    idEditando = fila ? fila[esq.pk] : null;

    document.getElementById("ct-modal-titulo").textContent = (esEdicion ? "Editar " : "Nuevo Registro en ") + tabla.toUpperCase();
    document.getElementById("ct-modal-campos").innerHTML = esq.campos.map(c => {
      const val = fila && fila[c.name] !== undefined && fila[c.name] !== null ? fila[c.name] : "";
      const ro = (esEdicion && c.name === esq.pk)
        ? 'readonly style="background:#f0f0f0; padding:8px; border:1px solid #ccc; border-radius:6px;"'
        : 'style="padding:8px; border:1px solid #ccc; border-radius:6px;"';
      if (c.type === "select") {
        const opts = c.options.map(o => `<option value="${o}" ${val === o ? "selected" : ""}>${o}</option>`).join("");
        return `<label style="display:flex; flex-direction:column; font-size:0.86rem; font-weight:600;">${c.label}<select name="${c.name}" ${ro}>${opts}</select></label>`;
      }
      return `<label style="display:flex; flex-direction:column; font-size:0.86rem; font-weight:600;">${c.label}<input type="${c.type}" name="${c.name}" value="${val}" ${c.required && !esEdicion ? "required" : ""} ${ro}></label>`;
    }).join("");

    document.getElementById("ct-modal").style.display = "flex";
  };

  window.ctCerrarModal = function () {
    const m = document.getElementById("ct-modal");
    if (m) m.style.display = "none";
  };

  window.ctGuardar = async function (e) {
    e.preventDefault();
    const datos = {};
    new FormData(e.target).forEach((v, k) => { datos[k] = v; });
    const url = esEdicion ? `/api/tabla/${tablaActiva}/${idEditando}` : `/api/tabla/${tablaActiva}`;
    const res = await fetch(url, {
      method: esEdicion ? "PUT" : "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify(datos)
    });
    const out = await res.json();
    if (res.ok) {
      ctCerrarModal();
      ctRecargarTabla(tablaActiva);
      ctRefrescarDashboardGerencial();
    } else {
      alert("Error: " + (out.error || "No se pudo guardar"));
    }
  };

  window.ctEliminar = async function (tabla, id) {
    if (!confirm(`¿Seguro que deseas eliminar el registro ${id} de ${tabla}?`)) return;
    const res = await fetch(`/api/tabla/${tabla}/${id}`, { method: "DELETE" });
    const out = await res.json();
    if (res.ok) {
      ctRecargarTabla(tabla);
      ctRefrescarDashboardGerencial();
    } else {
      alert("Error: " + (out.error || "No se pudo eliminar"));
    }
  };

  window.ctRefrescarDashboardGerencial = async function () {
    const res = await fetch("/api/dashboard-tablas-resumen");
    if (!res.ok) return;
    const data = await res.json();

    const canvases = document.querySelectorAll("canvas");
    if (!canvases.length) return;
    const ultimoBloque = canvases[canvases.length - 1].closest("div[class*='grid'], div[class*='chart'], section") || canvases[canvases.length - 1].parentElement.parentElement;
    if (!ultimoBloque) return;

    const fmt = (n) => "$ " + Number(n || 0).toLocaleString("es-CO");
    const rowsVen = (data.vendedores || []).map(v => `
      <tr>
        <td style="padding:8px; border-bottom:1px solid #eee; font-weight:600;">${v.vendedor}</td>
        <td style="padding:8px; border-bottom:1px solid #eee; text-align:center;">${v.total_ventas}</td>
        <td style="padding:8px; border-bottom:1px solid #eee; text-align:right;">${fmt(v.ingresos_generados)}</td>
        <td style="padding:8px; border-bottom:1px solid #eee; text-align:right;">${fmt(v.ticket_promedio)}</td>
      </tr>`).join("");

    const rowsCli = (data.top_clientes || []).map(c => `
      <tr>
        <td style="padding:8px; border-bottom:1px solid #eee;">${c.id_cliente}</td>
        <td style="padding:8px; border-bottom:1px solid #eee; font-weight:600;">${c.cliente}</td>
        <td style="padding:8px; border-bottom:1px solid #eee; text-align:center;">${c.tipo_cliente}</td>
        <td style="padding:8px; border-bottom:1px solid #eee; text-align:center;">${c.compras_realizadas}</td>
        <td style="padding:8px; border-bottom:1px solid #eee; text-align:right;">${fmt(c.inversion_total)}</td>
      </tr>`).join("");

    let cont = document.getElementById("ct-tablas-gerenciales");
    const htmlTablas = `
      <div style="background:#fff; padding:18px; border-radius:12px; box-shadow:0 4px 12px rgba(0,0,0,0.06);">
        <h4 style="margin:0 0 12px 0; color:#5a2328;">📊 RENDIMIENTO COMERCIAL POR VENDEDOR</h4>
        <table id="ct-ger-ven" style="width:100%; border-collapse:collapse; font-size:0.85rem;">
          <thead><tr style="background:#f8f4f3; color:#5a2328;">
            <th style="padding:8px; text-align:left;">Vendedor</th>
            <th style="padding:8px; text-align:center;">Ventas</th>
            <th style="padding:8px; text-align:right;">Facturación</th>
            <th style="padding:8px; text-align:right;">Ticket Prom.</th>
          </tr></thead>
          <tbody>${rowsVen}</tbody>
        </table>
      </div>
      <div style="background:#fff; padding:18px; border-radius:12px; box-shadow:0 4px 12px rgba(0,0,0,0.06);">
        <h4 style="margin:0 0 12px 0; color:#5a2328;">🏆 TOP CLIENTES POR FACTURACIÓN</h4>
        <table id="ct-ger-cli" style="width:100%; border-collapse:collapse; font-size:0.85rem;">
          <thead><tr style="background:#f8f4f3; color:#5a2328;">
            <th style="padding:8px; text-align:left;">ID</th>
            <th style="padding:8px; text-align:left;">Cliente</th>
            <th style="padding:8px; text-align:center;">Segmento</th>
            <th style="padding:8px; text-align:center;">Compras</th>
            <th style="padding:8px; text-align:right;">Total Comprado</th>
          </tr></thead>
          <tbody>${rowsCli}</tbody>
        </table>
      </div>`;

    if (cont) {
      cont.innerHTML = htmlTablas;
    } else {
      ultimoBloque.insertAdjacentHTML("afterend", `<div id="ct-tablas-gerenciales" style="display:grid; grid-template-columns:repeat(auto-fit, minmax(400px, 1fr)); gap:20px; margin-top:24px;">${htmlTablas}</div>`);
    }
  };

  // Interceptar clics en el menú lateral para tomar el control después de que la vista cambie
  document.addEventListener("click", (e) => {
    const item = e.target.closest("a, button, li, div");
    if (!item) return;
    const txt = item.textContent.trim().toLowerCase();
    const mapa = { pedidos: "pedidos", ventas: "ventas", productos: "productos", materiales: "materiales", clientes: "clientes", usuarios: "usuarios" };
    if (mapa[txt]) {
      setTimeout(() => ctRecargarTabla(mapa[txt]), 350);
    }
    if (txt.includes("dashboard gerencial")) {
      setTimeout(() => ctRefrescarDashboardGerencial(), 350);
    }
  }, true);

  // Inicializar al cargar y conectar WebSockets en tiempo real
  window.addEventListener("load", () => {
    const rol = obtenerRol();
    if (rol !== "Administrador") {
      document.querySelectorAll("a, button, li, div").forEach(el => {
        if (el.children.length <= 1 && el.textContent.trim().toLowerCase() === "usuarios") {
          el.style.display = "none";
        }
      });
    }
    setTimeout(() => {
      ctRecargarTabla(detectarTablaPorTitulo());
      ctRefrescarDashboardGerencial();
    }, 450);

    if (typeof io !== "undefined") {
      const sock = io();
      sock.on("actualizacion_datos", () => {
        ctRecargarTabla(detectarTablaPorTitulo());
        ctRefrescarDashboardGerencial();
        if (typeof loadDashboardAnalytics === "function") loadDashboardAnalytics();
        if (typeof fetchDashboardData === "function") fetchDashboardData();
      });
    }
  });
})();
