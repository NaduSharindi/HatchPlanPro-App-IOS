//
//  DashboardComponents.swift
//  HatchPlan Pro
//
//  Created by COBSCCOMP242P-063 on 2026-05-06.
//

import SwiftUI

// MARK: - Sensor Card UI
struct SensorCardView: View {
    let sensor: SensorData
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("HUMIDITY")
                    .font(.caption)
                    .foregroundColor(.gray)
                Text("\(sensor.humidity, specifier: "%.0f")%")
                    .font(.system(size: 28, weight: .bold))
            }
            Spacer()
            VStack(alignment: .trailing) {
                Text("TEMP")
                    .font(.caption)
                    .foregroundColor(.gray)
                Text("\(sensor.temperature, specifier: "%.1f")°C")
                    .font(.system(size: 28, weight: .bold))
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(15)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
        .padding(.horizontal)
    }
}

// MARK: - Batch Row UI
struct BatchRowView: View {
    let batch: Batch
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 5) {
                Text("Batch \(batch.id)")
                    .font(.headline)
                Text(batch.breed)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            Spacer()
            VStack(alignment: .trailing, spacing: 5) {
                Text("\(Int(batch.progress * 100))% Progress")
                    .font(.subheadline)
                    .bold()
                    .foregroundColor(batch.progress > 0.9 ? .green : .blue)
                Text(batch.approvalStatus)
                    .font(.caption)
                    .padding(4)
                    .background(batch.approvalStatus == "Approved" ? Color.green.opacity(0.2) : Color.orange.opacity(0.2))
                    .cornerRadius(5)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .padding(.horizontal)
    }
}
