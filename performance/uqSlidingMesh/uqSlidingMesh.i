Simulations:
  - name: sim1
    time_integrator: ti_1
    optimizer: opt1

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
    type: tpetra
    method: gmres 
    preconditioner: muelu 
    tolerance: 1e-5
    max_iterations: 50
    kspace: 50
    output_level: 0

realms:

  - name: realm_1
    mesh: uqvawt_corrected.exo
    use_edges: yes       

    time_step_control:
     target_courant: 20.0
     time_step_change_factor: 1.15
   
    equation_systems:
      name: theEqSys
      max_iterations: 2 
   
      solver_system_specification:
        pressure: solve_cont
        velocity: solve_scalar
        turbulent_ke: solve_scalar

      systems:
        - LowMachEOM:
            name: myLowMach
            max_iterations: 1
            convergence_tolerance: 1e-2

        - TurbKineticEnergy:
            name: myTke
            max_iterations: 1
            convergence_tolerance: 1.e-2

    initial_conditions:

      - constant: ic_1
        target_name: [block_1, block_2, block_3, block_4, block_5, block_6, block_7]
        value:
          pressure: 0
          turbulent_ke: 1.0e-6

      - user_function: ic_2
        target_name: [block_1, block_2, block_3, block_4, block_5, block_6, block_7]
        user_function_name:
         velocity: wind_energy_taylor_vortex
        user_function_parameters:
         velocity: [-225.0,0.0,50.0,50.0,6.0] 

    material_properties:
      target_name: [block_1, block_2, block_3, block_4, block_5, block_6, block_7]
      specifications:
        - name: density
          type: constant
          value: 1.226

        - name: viscosity
          type: constant
          value: 1.8e-5

    boundary_conditions:

    - inflow_boundary_condition: bc_left
      target_name: surface_1
      inflow_user_data:
        velocity: [6.0,0.0]
        turbulent_ke: 0.01

    - open_boundary_condition: bc_right
      target_name: surface_2
      open_user_data:
        pressure: 0.0
        turbulent_ke: 0.0

    - symmetry_boundary_condition: bc_top_bot
      target_name: surface_3
      symmetry_user_data:

    - wall_boundary_condition: bc_wingT
      target_name: surface_4
      wall_user_data:
        user_function_name:
         velocity: wind_energy
        user_function_parameters:
         velocity: [1.0]
        use_wall_function: yes 

    - wall_boundary_condition: bc_wingL
      target_name: surface_5
      wall_user_data:
        user_function_name:
         velocity: wind_energy
        use_wall_function: yes 
        user_function_parameters:
         velocity: [1.0] 

    - wall_boundary_condition: bc_wingR
      target_name: surface_6
      wall_user_data:
        user_function_parameters:
         velocity: [1.0]
        use_wall_function: yes 
        user_function_name:
         velocity: wind_energy

    - contact_boundary_condition: bc_contI
      target_name: surface_7
      contact_user_data:
        max_search_radius: 87.3
        min_search_radius: 86.7
        search_block: block_6
        extrusion_distance: 0.2

    - contact_boundary_condition: bc_contO
      target_name: surface_8
      contact_user_data:
        max_search_radius: 87.1
        min_search_radius: 86.5
        search_block: block_5
        extrusion_distance: 0.2

    solution_options:
      name: myOptions
      turbulence_model: ksgs

      mesh_motion:
        - name: mmOne
          target_name: [block_1, block_2, block_3, block_4, block_5]
          omega: 1.0

        - name: mmTwo
          target_name: [block_6, block_7]
          omega: 0.0

      options:
        - hybrid_factor:
            velocity: 1.0
            turbulent_ke: 1.0

        - alpha_upw:
            velocity: 1.0
            turbulent_ke: 1.0 

        - limiter:
            pressure: no
            velocity: no
            turbulent_ke: yes

        - projected_nodal_gradient:
            pressure: edge 

    output:
      output_data_base_name: uqSlidingMesh.e
      output_frequency: 10
      output_node_set: no 
      output_variables:
       - dual_nodal_volume
       - velocity
       - pressure
       - turbulent_viscosity
       - turbulent_ke
       - mesh_displacement

    post_processing:
    
    - type: surface
      physics: surface_force_and_moment
      output_file_name: nalu_s4.dat
      frequency: 2 
      parameters: [0,0]
      target_name: surface_4

    - type: surface
      physics: surface_force_and_moment
      output_file_name: nalu_s5.dat
      frequency: 2
      parameters: [0,0]
      target_name: surface_5

    - type: surface
      physics: surface_force_and_moment
      output_file_name: nalu_s6.dat
      frequency: 2
      parameters: [0,0]
      target_name: surface_6

Time_Integrators:
  - StandardTimeIntegrator:
      name: ti_1
      start_time: 0
      termination_time: 0.04 
      time_step: 0.002
      time_stepping_type: fixed 
      time_step_count: 0

      realms:
        - realm_1