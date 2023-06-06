package com.health;

import java.awt.Color;
import java.awt.Dimension;
import java.util.List;
import javax.swing.JFrame;
import org.jfree.chart.ChartFactory;
import org.jfree.chart.ChartPanel;
import org.jfree.chart.JFreeChart;
import org.jfree.chart.plot.PlotOrientation;
import org.jfree.data.xy.DefaultXYDataset;
import com.simpli.HibernateUtil;
import org.hibernate.Session;
import org.hibernate.query.Query;

public class VitalsChart {
    public static void main(String[] args) {
        // Fetch the vital data for the patient using Hibernate
        try {
            // Retrieve the vital data for the patient
            Session session = HibernateUtil.getSessionFactory().openSession();
            Query query = session.createQuery("FROM Vital WHERE patientId = :1");
            query.setParameter("patientId", 1);
            List<Vital> vitals = query.list();
            session.close();

            // Create the XYDataset for the chart
            DefaultXYDataset dataset = new DefaultXYDataset();
            double[][] data = new double[2][vitals.size()];

            for (int i = 0; i < vitals.size(); i++) {
                Vital vital = vitals.get(i);
                String date = vital.getRecordedTime();
                data[1][i] = vital.getBpLow();
            }

            dataset.addSeries("BP Low", data);

            // Create the JFreeChart
            JFreeChart chart = ChartFactory.createXYLineChart(
                    "Patient Vital Information", // Chart title
                    "Time", // X-axis label
                    "BP Low", // Y-axis label
                    dataset, // Dataset
                    PlotOrientation.VERTICAL, // Plot orientation
                    true, // Show legend
                    true, // Use tooltips
                    false // Configure chart to generate URLs?
            );

            // Customize the chart
            chart.getPlot().setBackgroundPaint(Color.WHITE);

            // Create a JFrame to display the chart
            JFrame frame = new JFrame("Vitals Chart");
            frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
            frame.setPreferredSize(new Dimension(500, 400));
            ChartPanel chartPanel = new ChartPanel(chart);
            frame.setContentPane(chartPanel);
            frame.pack();
            frame.setVisible(true);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}

