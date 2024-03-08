//
//  WeakRef+ItemCellControllerOutput.swift
//  Clickmelive
//
//  Created by Can on 5.03.2024.
//

extension WeakRef: ItemCellControllerOutput where T: ItemCellControllerOutput {
    func selection(viewModel: ItemViewModel) {
        object?.selection(viewModel: viewModel)
    }
}
