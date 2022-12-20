<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<!DOCTYPE html>
<html lang="en">

<jsp:include page="head.jsp"></jsp:include>
<jsp:include page="theme-loader.jsp"></jsp:include>
<body>
	<!-- Pre-loader start -->

	<!-- Pre-loader end -->
	<div id="pcoded" class="pcoded">
		<div class="pcoded-overlay-box"></div>
		<div class="pcoded-container navbar-wrapper">

			<jsp:include page="navbar.jsp"></jsp:include>



			<div class="pcoded-main-container">
				<div class="pcoded-wrapper">

					<jsp:include page="navbarmainmenu.jsp"></jsp:include>
					<div class="pcoded-content">
						<!-- Page-header start -->
						<jsp:include page="page-header.jsp"></jsp:include>
						<!-- Page-header end -->
						<div class="pcoded-inner-content">
							<!-- Main-body start -->
							<div class="main-body">
								<div class="page-wrapper">
									<!-- Page-body start -->
									<div class="page-body">

										<h3>Cadastro de Usuarios.</h3>

										<div class="row">
											<div class="col-sm-12">
												<!-- Basic Form Inputs card start -->
												<div class="card">
													<div class="card-header">
														<h5>Cadastrar novo usuario.</h5>

													</div>
													<div class="card-block">
														<h4 class="sub-title">Dados basicos.</h4>


														<form
															action="<%=request.getContextPath()%>/ServletUsuarioController"
															method="post" id="formUser">


															<input type="hidden" name="acao" id="acao" value="">

															<div class="form-group row">
																<label class="col-sm-2 col-form-label">ID:</label>
																<div class="col-sm-10">
																	<input type="text" name="id" id="id"
																		readonly="readonly"
																		class="form-control form-control-normal"
																		autocomplete="off" required="required"
																		value="${modolLogin.id}"
																		placeholder="Id unico do usuário..">
																</div>
															</div>

															<div class="form-group row">
																<label class="col-sm-2 col-form-label">Nome:</label>
																<div class="col-sm-10">
																	<input type="text" name="nome" id="nome"
																		class="form-control form-control-normal"
																		autocomplete="off" required="required"
																		value="${modolLogin.nome}"
																		placeholder="Nome completo.">
																</div>
															</div>

															<div class="form-group row">
																<label class="col-sm-2 col-form-label">Email:</label>
																<div class="col-sm-10">
																	<input type="email" name="email" id="email"
																		class="form-control form-control-normal"
																		autocomplete="off" required="required"
																		value="${modolLogin.email}"
																		placeholder="Digite  o email">
																</div>
															</div>

															<div class="form-group row">
																<label class="col-sm-2 col-form-label">Login:</label>
																<div class="col-sm-10">
																	<input type="text" name="login" id="login"
																		class="form-control form-control-normal"
																		autocomplete="off" required="required"
																		value="${modolLogin.login}"
																		placeholder="Digite o login">
																</div>
															</div>
															<div class="form-group row">
																<label class="col-sm-2 col-form-label">Senha:</label>
																<div class="col-sm-10">
																	<input type="password" name="senha" id="senha"
																		class="form-control form-control-normal"
																		autocomplete="off" required="required"
																		value="${modolLogin.senha}"
																		placeholder="Digite a senha">
																</div>
															</div>

															<button type="button"
																class="btn waves-effect waves-light btn-primary">
																<class ="icofont
																	icofont-check-circled" onclick="limparForm()">Novo.







																
															</button>
															<button class="btn waves-effect waves-light btn-success">
																<i class="icofont icofont-check-circled"></i>Salvar.
															</button>
															<button type="button"
																class="btn waves-effect waves-light btn-info">
																<class ="icofont
																	icofont-info-square" onclick="criarDelete()">Excluir.







																
															</button>


															<button type="button" class="btn btn-secondary"
																data-toggle="modal" data-target="#exampleModalUsuario">
																Pesquisar.</button>



														</form>


													</div>

												</div>
											</div>
											<span>${msg}</span>
										</div>

									</div>
								</div>
								<!-- Page-body end -->
							</div>
							<div id="styleSelector"></div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>



	<!-- Modal -->
	<div class="modal fade" id="exampleModalUsuario" tabindex="-1"
		role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">Pesquisa de
						usuários</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">


					<form>
						<div class="form-group">
							<label for="exampleInputEmail1">Nome:</label> <input type="text"
								class="form-control" id="nomeBusca" aria-describedby="nomeBusca"
								placeholder="Nome">

						</div>

						<button class="btn btn-success" type="button"
							onclick="buscarUsuario();">Buscar</button>							
							
					</form>

				</div>
				<div class="modal-footer">

					<table class="table" id="tabelaresultados">
						<thead>
							<tr>
								<th scope="col">ID</th>
								<th scope="col">Nome</th>
								<th scope="col">Visualizar</th>

							</tr>
						</thead>
						<tbody>

						</tbody>
					</table>


				</div>
				<button type="button" class="btn btn-secondary" data-dismiss="modal">Fechar</button>

			</div>
		</div>

	</div>




	<jsp:include page="javascriptfile.jsp"></jsp:include>
	<script type="text/javascript">
	
	function verEditar(id) {
		
		 var urlAction = document.getElementById('formUser').action;
		
		 window.location.href = urlAction + '?acao=buscarEditar&id='+id;
		
	}	
	


	function buscarUsuario() {
	    
	    var nomeBusca = document.getElementById('nomeBusca').value;
	    
	    if (nomeBusca != null && nomeBusca != '' && nomeBusca.trim() != ''){ /*Validando que tem que ter valor pra buscar no banco*/
		
		 var urlAction = document.getElementById('formUser').action;
		
		 $.ajax({
		     
		     method: "get",
		     url : urlAction,
		     data : "nomeBusca=" + nomeBusca + '&acao=buscarUserAjax',
		     success: function (response) {
			 
			 var json = JSON.parse(response);
			 
			 
			 $('#tabelaresultados > tbody > tr').remove();
			 
			  for(var p = 0; p < json.length; p++){
			      $('#tabelaresultados > tbody').append('<tr> <td>'+json[p].id+'</td> <td> '+json[p].nome+'</td> <td><button onclick="verEditar('+json[p].id+')" type="button" class="btn btn-info">Ver</button></td></tr>');
			  }
			  
			  document.getElementById('totalResultados').textContent = 'Resultados: ' + json.length;
			 
		     }
		     
		 }).fail(function(xhr, status, errorThrown){
		    alert('Erro ao buscar usuário por nome: ' + xhr.responseText);
		 });
		
		
	    }
	    
	}
		function criarDeleteComAjax() {
		    
		    if (confirm('Deseja realmente excluir os dados?')){
			
			 var urlAction = document.getElementById('formUser').action;
			 var idUser = document.getElementById('id').value;
			 
			 $.ajax({
			     
			     method: "get",
			     url : urlAction,
			     data : "id=" + idUser + '&acao=deletarajax',
			     success: function (response) {
				 
				  limparForm();
				  document.getElementById('msg').textContent = response;
			     }
			     
			 }).fail(function(xhr, status, errorThrown){
			    alert('Erro ao deletar usuário por id: ' + xhr.responseText);
			 });
			 
			  
		    }
		    
		}

		function criarDelete() {

			if (confirm('Deseja realmente excluir os dados?')) {

				document.getElementById("formUser").method = 'get';
				document.getElementById("acao").value = 'deletar';
				document.getElementById("formUser").submit();
			}

		}

		function limparForm() {

			var elementos = document.getElementById("formUser").elements; /*Retorna os elementos html dentro do form*/

			for (p = 0; p < elementos.length; p++) {
				elementos[p].value = '';
			}
		}
	</script>
</body>

</html>