Simulations:
  - name: sim1
    time_integrator: ti_1
    optimizer: opt1
    error_estimator: errest_1

linear_solvers:

  - name: solve_scalar
    type: tpetra
    method: gmres
    preconditioner: sgs 
    tolerance: 1e-5
    max_iterations: 50
    kspace: 50
    output_level: 0

  - name: solve_cont
    type: epetra
    method: gmres 
    preconditioner: ML
    tolerance: 1e-5
    max_iterations: 50
    kspace: 50
    output_level: 0
    recompute_preconditioner: no

realms:

  - name: realm_1
    mesh: 2dTquad_100_P2.g
    use_edges: no     

    equation_systems:
      name: theEqSys
      max_iterations: 1
   
      solver_system_specification:
        pressure: solve_cont
        velocity: solve_scalar
        dpdx: solve_scalar

      systems:
        - LowMachEOM:
            name: myLowMach
            max_iterations: 1
            convergence_tolerance: 1e-2
            manage_png: yes

    initial_conditions:

      - user_function: icUser
        target_name: block_1
        user_function_name:
         velocity: SteadyTaylorVortex
         pressure: SteadyTaylorVortex 
         
    material_properties:
      target_name: block_1

      specifications:

        - name: density
          type: constant
          value: 1.0

        - name: viscosity
          type: constant
          value: 0.001

    boundary_conditions:

    - periodic_boundary_condition: bc_left_right
      target_name: [surface_1, surface_2]
      periodic_user_data:
        search_tolerance: 0.0001 

    - periodic_boundary_condition: bc_top_bot
      target_name: [surface_3, surface_4]
      periodic_user_data:
        search_tolerance: 0.0001 

    solution_options:
      name: myOptions
      turbulence_model: laminar
  
      options:

        - hybrid_factor:
            velocity: 0.0

        - limiter:
            pressure: no
            velocity: no

        - element_source_terms:
            momentum: [SteadyTaylorVortex, momentum_time_derivative]

    output:
      output_data_base_name: naluUniformSteadyTV_100_P2_png.e
      output_frequency: 5
      output_node_set: no 
      output_variables:
       - dual_nodal_volume
       - velocity
       - pressure

Time_Integrators:
  - StandardTimeIntegrator:
      name: ti_1
      start_time: 0
      termination_step_count: 25
      time_step: 100.0e-6
      time_stepping_type: fixed 
      time_step_count: 0
      second_order_accuracy: no

      realms:
        - realm_1
